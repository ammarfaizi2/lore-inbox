Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261773AbVAYBLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbVAYBLf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 20:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbVAYBEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 20:04:13 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:24743 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261735AbVAYBBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 20:01:35 -0500
Message-ID: <41F59A50.1090203@ens-lyon.fr>
Date: Tue, 25 Jan 2005 02:01:04 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.fr>
Reply-To: Brice.Goglin@ens-lyon.org
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1
References: <20050124021516.5d1ee686.akpm@osdl.org>
In-Reply-To: <20050124021516.5d1ee686.akpm@osdl.org>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030306070408060300040304"
X-Spam-Report: *  1.1 NO_DNS_FOR_FROM Domain in From header has no MX or A DNS records
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030306070408060300040304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Andrew Morton a écrit :
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc1/2.6.11-rc1-mm1/
> 
> 
> - Lots of updates and fixes all over the place.
> 
> - On my test box there is no flashing cursor on the vga console.  Known bug,
>   please don't report it.
> 
>   Binary searching shows that the bug was introduced by
>   cleanup-vc-array-access.patch but that patch is, unfortunately, huge.

Hi Andrew,

ACPI does not work anymore on my Compaq Evo N600c
(no thermal zone, no fan, no battery, ...).
It works great on Linus' 2.6.11-rc2, and (from what I remember)
it was working on the last -mm releases I tried.

Here's a bunch of lines from dmesg.
.config and lspci attached.

Regards,
Brice


exresnte-0133 [24] ex_resolve_node_to_val: No object attached to node e7fcd548
  dswexec-0446 [21] ds_exec_end_op        : [Acquire]: Could not resolve operands, AE_AML_NO_OPERAND
  psparse-1138: *** Error: Method execution failed [\_SB_.C03E.C053.C0D1.C12A] (Node c15e5788), AE_AML_NO_OPERAND
  psparse-1138: *** Error: Method execution failed [\_SB_.C1A2._PSR] (Node c15ed8c8), AE_AML_NO_OPERAND
  acpi_ac-0098 [12] acpi_ac_get_state     : Error reading AC Adapter state
ACPI: Battery Slot [C19F] (battery absent)
ACPI: Battery Slot [C1A0] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [C1A3]
ACPI: Lid Switch [C1A4]
ACPI: Fan [C1F6] (off)
ACPI: Fan [C1F7] (off)
ACPI: Fan [C1F8] (off)
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
exresnte-0133 [31] ex_resolve_node_to_val: No object attached to node e7fcd548
  dswexec-0446 [28] ds_exec_end_op        : [Acquire]: Could not resolve operands, AE_AML_NO_OPERAND
  psparse-1138: *** Error: Method execution failed [\_SB_.C03E.C053.C0D1.C11A] (Node c15e5b48), AE_AML_NO_OPERAND
  psparse-1138: *** Error: Method execution failed [\_TZ_.C11A] (Node c15ef3c8), AE_AML_NO_OPERAND
  psparse-1138: *** Error: Method execution failed [\_TZ_.C1F1] (Node c15ef0c8), AE_AML_NO_OPERAND
  psparse-1138: *** Error: Method execution failed [\_TZ_.TZ1_._TMP] (Node c15f05c8), AE_AML_NO_OPERAND
ACPI wakeup devices:
C052 C17E C185 C0A4 C0AA C19F C1A0 C1A3 C1A4
ACPI: (supports S0 S1 S3 S4 S4bios S5)
exresnte-0133 [26] ex_resolve_node_to_val: No object attached to node e7fcd548
  dswexec-0446 [23] ds_exec_end_op        : [Acquire]: Could not resolve operands, AE_AML_NO_OPERAND
  psparse-1138: *** Error: Method execution failed [\_SB_.C03E.C053.C0D1.C119] (Node c15e5b88), AE_AML_NO_OPERAND
  psparse-1138: *** Error: Method execution failed [\_GPE._L10] (Node c15f0248), AE_AML_NO_OPERAND
    evgpe-0552: *** Error: AE_AML_NO_OPERAND while evaluating method [_L10] for GPE[ 0]

--------------030306070408060300040304
Content-Type: application/x-gunzip;
 name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="config.gz"

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
Qy/PjYDJ4v//Dz+D+XgCjwAA
--------------030306070408060300040304
Content-Type: application/x-gunzip;
 name="lspci.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="lspci.gz"

H4sICOSZ9UEAA2xzcGNpAJ2TS2+CQBSF9/0VN+lGF9UZNA26Q2qUVFJT0KZLHK46CTBmZmjq
v+/FR31UTWMCC4ZzvvvgwBhj3c3VYDBUxsJMy3SBXQgKixn4Sq8a4Dpui0F1+0u5Mmi30t5G
CjWNX8Cc+gPbwzjBxn7wT5Y3GF9F8ZRQk6hH5sJqlWWo/+AY972m74UbXW1YzuCR13cofoLi
d6CcyyjnDlTrEgpv74pxCNVMZrgRHa+pfUyZEyWIvOuUqpNKsCeMxv6lbua0o+ClD5L8ep6I
qyjSTDhj5wi+TdJ04IFQ+Sqxckati6M1eXEAMYploTK1kGiIL+A9SVEV20mlXUP4DKPPHdLp
shYh/USnvdL8Thjjd1KZjdVljoU11YJ422HHNn6PrV1VU3leFlLQANTXSf8L1AjR2ljMDdTm
SueoYVQKgkEohVaYoSA5uU0dRjF8yCJUKebn6aZSLpXq2yXqgv4DcTtMIdQCf0gZGr+/NavV
T+nkNawfAIc0nieESnWoVFhmVuaYygSSMpXqpGQ/ig4fZk2PvOO64NHLhVZPfIvk1P0P4+Vy
BjQEAAA=
--------------030306070408060300040304--
