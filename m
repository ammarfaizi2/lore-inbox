Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbVHTVfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbVHTVfi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 17:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbVHTVfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 17:35:38 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:23470 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751232AbVHTVfh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 17:35:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=Eu6lH20YEaZPTWUuBoFct6qNbsRQFu2emRpKoBnWqpck9ZamcWbWMaNkzlcT4+vxcExqwOqVX/YPi6GMAlz+Yg7dMZ+hTFe5ykKpmTd8NwlmpPTnFcr+HdSlE4Z8VZPlKfgeQeeiKz6J4zSNEgOsVXTJdjVSmnnWvmy3yfteDz0=
Date: Sat, 20 Aug 2005 17:35:27 -0400
To: Peter Buckingham <peter@pantasys.com>
Cc: Sean Bruno <sean.bruno@dsl-only.net>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-git10 test report [x86_64](WITHOUT NVIDIA MODULE)
Message-ID: <20050820213527.GB13127@nineveh.rivenstone.net>
Mail-Followup-To: Peter Buckingham <peter@pantasys.com>,
	Sean Bruno <sean.bruno@dsl-only.net>, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org
References: <1124405533.14825.24.camel@home-lap> <20050818230349.GC22993@wotan.suse.de> <1124410753.14825.32.camel@home-lap> <4305FCF1.6020905@pantasys.com> <20050819154639.GL22993@wotan.suse.de> <4306002F.4000000@pantasys.com> <20050819155332.GM22993@wotan.suse.de> <430601C5.5080505@pantasys.com> <1124467902.14825.41.camel@home-lap> <43060731.10002@pantasys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43060731.10002@pantasys.com>
User-Agent: Mutt/1.5.6+20040907i
From: jfannin@gmail.com (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2005 at 09:22:09AM -0700, Peter Buckingham wrote:

> >The machine is working quite a bit better with pci=noacpi in leu of
> >disabling ACPI in the BIOS, but there are still those nasty errors in
> >reference to the ACPI tables being broken:
> >    ACPI-0362: *** Error: Looking up [\_SB_.PCI0.LNK0] in namespace,
> >AE_NOT_FOUND
> >search_node ffff8101428572c0 start_node ffff8101428572c0 return_node
> >0000000000000000
>
> since it doesn't look like you'll get a bios fix for this you may want
> to look at building a custom dsdt. the kernel can load a custom dsdt
> from an initrd/initramfs. have a look at the acpi site (acpi.sf.net?).
> they talk about what's needed to do this. basically you can get your
> dsdt from /proc/acpi/dsdt and disassemble it using the iasl tools, fix
> it and then load it with an initrd. note that this is not really a
> trivial task :-(

    Also, please file a bug report against the ACPI component at
http://bugzilla.kernel.org .  Ultimately the Linux ACPI component must
deal with these sorts of errors, or convince the BIOS authors not to
make them!

--
Joseph Fannin
jfannin@gmail.com

"That's all I have to say about that." -- Forrest Gump.
