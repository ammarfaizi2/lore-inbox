Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272068AbTG2UdR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 16:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272069AbTG2UdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 16:33:17 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:13198 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S272068AbTG2UdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 16:33:16 -0400
Date: Tue, 29 Jul 2003 16:31:40 -0400 (EDT)
From: Richard A Nelson <cowboy@vnet.ibm.com>
To: "Grover, Andrew" <andrew.grover@intel.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: ACPI failure (2.6.0-test<x> and 2.4.22-pre<x>)
In-Reply-To: <F760B14C9561B941B89469F59BA3A8470255EEB2@orsmsx401.jf.intel.com>
Message-ID: <Pine.LNX.4.56.0307291536100.15041@onqynaqf.yrkvatgba.voz.pbz>
References: <F760B14C9561B941B89469F59BA3A8470255EEB2@orsmsx401.jf.intel.com>
X-No-Markup: yes
x-No-ProductLinks: yes
x-No-Archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jul 2003, Grover, Andrew wrote:

> Could you try, say, 2.5.70? That would help me understand if it's a
> regression or not.

looks to be the same problem, I got a little more info - and compared
it to 2.6.0-test2-mm1; forgive the formatting, this was copied by hand
(its a pain being with only one box):

anything before this was cut of by the size of the screen

EIP: 0060: c01efc11   (2.6.0-test2-mm1 version)
EFLAGS: 00010202
EIP at: acpi_ut_remove_allocation+0xb5/0x126
EAX: 00000003  EBX: c136c59c  ECX: 00000000  EDX: 00000001
ESI: 00000000  EDI: 00000000  EBP: cff118c4  ESP: cff118c8
ds:  007b      es:  007b      ss:  0068
...
... acpi_ps_parse_aml+0xa2/0x250
... acpi_power_add+0x126/0x1c4
... acpi_bus_scan
...

> If that also fails, then I think determining exactly where it is oopsing
> (probably via printks) would be the next best way to go.

>From other messages, here I found and extracted the acpi_dsdt.aml if
that'll help with anything (can't make much sense of it myself, but
was surprised to see special casing for win98/nt/me in the init section)

-- 
Rick Nelson
I can saw a woman in two, but you won't want to look in the box when I do
'For My Next Trick I'll Need a Volunteer' -- Warren Zevon
