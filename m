Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130527AbQKANQp>; Wed, 1 Nov 2000 08:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130090AbQKANQZ>; Wed, 1 Nov 2000 08:16:25 -0500
Received: from styx.suse.cz ([195.70.145.226]:33533 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S130527AbQKANQV>;
	Wed, 1 Nov 2000 08:16:21 -0500
Date: Wed, 1 Nov 2000 13:58:58 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mousedev uses userspace pointers without copy_{to,from}_user
Message-ID: <20001101135858.B583@suse.cz>
In-Reply-To: <20001026235728.A6232@suse.cz> <18835.972652671@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <18835.972652671@redhat.com>; from dwmw2@infradead.org on Fri, Oct 27, 2000 at 02:17:51PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2000 at 02:17:51PM +0100, David Woodhouse wrote:
> 
> 
> static ssize_t mousedev_write(struct file * file, const char * buffer, size_t count, loff_t *ppos)
> {
>         struct mousedev_list *list = file->private_data;
>         unsigned char c;
>         int i;
> 
>         for (i = 0; i < count; i++) {
> 
>                 c = buffer[i];
> 
> 
> oops. Can we make this die horribly on x86, just for a few kernel releases?
> Along with turning on spinlock debugging, which would have shown up the USB 
> audio problem months ago.

Ok, fixed in the CVS, a patch for the kernel to follow soon.

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
