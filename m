Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261427AbSKKV4C>; Mon, 11 Nov 2002 16:56:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261446AbSKKV4C>; Mon, 11 Nov 2002 16:56:02 -0500
Received: from palrel13.hp.com ([156.153.255.238]:29416 "HELO palrel13.hp.com")
	by vger.kernel.org with SMTP id <S261427AbSKKV4B>;
	Mon, 11 Nov 2002 16:56:01 -0500
To: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>
Cc: "'Mario Smarduch '" <cms063@email.mot.com>,
       "'davidm+AEA-hpl.hp.com '" <davidm@hpl.hp.com>,
       "'Mario Smarduch '" <CMS063@motorola.com>,
       "'linux-ia64+AEA-linuxia64.org '" <linux-ia64@linuxia64.org>,
       "'linux-kernel+AEA-vger.kernel.org '" <linux-kernel@vger.kernel.org>,
       grundler@cup.hp.com
Subject: Re: [Linux-ia64] RE: +AFs-Linux-ia64+AF0- reader-writer livelock proble 
In-Reply-To: Your message of "Mon, 11 Nov 2002 14:36:38 CST."
             <3FAD1088D4556046AEC48D80B47B478C0101F4F7@usslc-exch-4.slc.unisys.com> 
References: <3FAD1088D4556046AEC48D80B47B478C0101F4F7@usslc-exch-4.slc.unisys.com> 
Date: Mon, 11 Nov 2002 14:02:32 -0800
From: Grant Grundler <grundler@cup.hp.com>
Message-Id: <20021111220232.C94F712C0C@debian.cup.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Van Maren, Kevin" wrote:
> It is also possible that a processor can get stuck +ACI-forever+ACI-
> spinning in the kernel with interrupts disabled trying to
> acquire a lock, and never succeed, without the rest of the
> kernel going south.  If that happens, and application will
> be livelocked, but the rest of the system will function.

Probably not. ia64 systems (and x86 systems with IO xapic) direct
IO interrupts to specific CPUs. Devices would not get serviced
in the above case and IO to/from those devices would come to a
grinding halt. It would look more like "dead" lock than "live" lock.


> It really depends on the particular circumstances.

yes. But it sounds very likely to me.

grant
