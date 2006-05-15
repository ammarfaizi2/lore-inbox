Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965215AbWEOURi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965215AbWEOURi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 16:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965220AbWEOURh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 16:17:37 -0400
Received: from nz-out-0102.google.com ([64.233.162.198]:16746 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965215AbWEOURh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 16:17:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S/xZE9TZQ0VtawnL4pTeYxZljlbU5/ALXTO6RC1yulQvoe5w29A6tCcaM+afAGievapCL1+odoN79PU7PFW/f3KnoBpjpLdQtFiKsjKU1aAfF5Xtutz6eRAIzX2rTHz3b7DIHxjC8W3iEMAcFD9PxrvyhodJ6S4RodXTdW6HkIw=
Message-ID: <6bffcb0e0605151317u51bbf67ey124b808fad920d36@mail.gmail.com>
Date: Mon, 15 May 2006 22:17:36 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-rc4-mm1
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de,
       "Jean Delvare" <khali@linux-fr.org>,
       "Kumar Gala" <galak@kernel.crashing.org>
In-Reply-To: <20060515122613.32661c02.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060515005637.00b54560.akpm@osdl.org>
	 <6bffcb0e0605151137v25496700k39b15a40fa02a375@mail.gmail.com>
	 <20060515115302.5abe7e7e.akpm@osdl.org>
	 <6bffcb0e0605151210x21eb0d24g96366ce9c121c26c@mail.gmail.com>
	 <20060515122613.32661c02.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/06, Andrew Morton <akpm@osdl.org> wrote:
> Great, thanks.   Here's the relevant part:
>
> modprobe      D 00000019  2740  2163   2129                     (NOTLB)
>        f0915e60 f1d7b694 8422805f 00000019 f0915e08 c10819a3 f1d7b694 f0915e18
>        00000007 f7e5f374 f7e5f250 f7f0f110 c741cf00 8429b934 00000019 000738d5
>        00000001 f1e6ac54 c101732e f0915e48 c10168d4 f887dba0 00000246 00000001
> Call Trace:
>  <c11d768e> wait_for_completion+0x8e/0x108   <c1180fae> i2c_del_adapter_nolock+0x255/0x277
>  <c1180fe7> i2c_del_adapter+0x17/0x28   <f887c023> i801_remove+0xd/0x2f [i2c_i801]
>  <c10eeb69> pci_device_remove+0x19/0x2c   <c11395a7> __device_release_driver+0x63/0x79
>  <c1139889> driver_detach+0x94/0xc4   <c1138d58> bus_remove_driver+0x5d/0x79
>  <c11399a2> driver_unregister+0xb/0x18   <c10eecd4> pci_unregister_driver+0x13/0xa5
>  <f887c9a5> i2c_i801_exit+0xd/0xf [i2c_i801]   <c103d3a8> sys_delete_module+0x19e/0x1d6
>  <c11dab67> sysenter_past_esp+0x54/0x75
>
> I'd assume that Kumar's i2c-add-support-for-virtual-i2c-adapters.patch is
> the culprit.

Unfortunately it's not this patch.
I'll check all Kumar's patches.

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
