Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWAJMfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWAJMfm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 07:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWAJMfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 07:35:42 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:60959 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750783AbWAJMfl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 07:35:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pwx+mzDIMalGiyfUSPVQWeLy+4+UNoHxP1eWfLrauzPJOsbyBRyjtQBJQZdFtX4zaT86kYl0FEhrkSYhcvUBL3V62VnROXVCfWzP2TW0L9mMrHwbju7hl9+/Pv+IbakWamzlclBIJ69nAlA+O5E7WPTmk5HQKdhiyFt0/E+FQkU=
Message-ID: <9a8748490601100435h1a7d81abkea70d3f29f2b4e44@mail.gmail.com>
Date: Tue, 10 Jan 2006 13:35:40 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.15-mm2 : Badness in __mutex_unlock_slowpath
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <20060110043300.7edff1f7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a8748490601100419s43233d74tf6e1a9f3e7a557f1@mail.gmail.com>
	 <20060110043300.7edff1f7.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/06, Andrew Morton <akpm@osdl.org> wrote:
> Jesper Juhl <jesper.juhl@gmail.com> wrote:
> >
> > Just got this in dmesg a little while ago with 2.6.15-mm2 :
> >
> >  [ 9294.769000] Badness in __mutex_unlock_slowpath at kernel/mutex.c:214
> >  [ 9294.769000]  [<c0103e77>] dump_stack+0x17/0x20
> >  [ 9294.769000]  [<c031c1a0>] __mutex_unlock_slowpath+0x220/0x260
> >  [ 9294.769000]  [<c031bb0b>] mutex_unlock+0xb/0x10
> >  [ 9294.769000]  [<f8e185d7>] snd_pcm_oss_write+0x37/0x70 [snd_pcm_oss]
> >  [ 9294.769000]  [<c0165a7a>] vfs_write+0x8a/0x160
> >  [ 9294.769000]  [<c0165bfd>] sys_write+0x3d/0x70
> >  [ 9294.769000]  [<c0103009>] syscall_call+0x7/0xb
>
> That's the alsa breakage - fixed now.
>
Ok, thanks, I'll ignore it until 2.6.15-mm3 then :)

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
