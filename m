Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277825AbRJIQte>; Tue, 9 Oct 2001 12:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277823AbRJIQtY>; Tue, 9 Oct 2001 12:49:24 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:1800 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S277822AbRJIQtJ> convert rfc822-to-8bit; Tue, 9 Oct 2001 12:49:09 -0400
X-Apparently-From: <xioborg@yahoo.com>
From: Steve Brueggeman <xioborg@yahoo.com>
To: Jan Hudec <bulb@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: proc file system
Date: Tue, 09 Oct 2001 11:49:38 -0500
Message-ID: <o7a6stc9qhk57g9p6s3is4m03897k6rari@4ax.com>
In-Reply-To: <200110052202.f95M2Ig16051@mail.swissonline.ch> <20011006173025.F12624@arthur.ubicom.tudelft.nl> <20011009154134.C28423@artax.karlin.mff.cuni.cz>
In-Reply-To: <20011009154134.C28423@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, to get tail -f to work, minimally you'll have to support
maintaining a fileposition, so tell() and seek() have something useful
to work on.  It's been a while since I looked at the source for tail,
pretty much for similar reasons (wanted to follow a /proc file).  Most
/proc files are considered (relatively) fixed-length files, who's
contents get updated.  tail -f expects to follow a file that is
growing in size.

I don't have sources in front of me, so hopefully someone else will
step-up and provide more detail than I have.

Steve Brueggeman


On Tue, 9 Oct 2001 15:41:34 +0200, you wrote:

>> On Sat, Oct 06, 2001 at 12:02:18AM +0200, llx@swissonline.ch wrote:
>> > i've written a prog interface for my logger utility to make it easy
>> > to transport my logging information from kernel to userspace using
>> > shell commands. now i want to use tail -f /prog/<mylogfile>. what
>> > do i have to do for that to work. when using tail my loginfo gets
>> > read form my ringbuffer, but nothing gets printed in the terminal.
>> 
>> I think you actually want a character device instead of a /proc file.
>
>Could you please explain why? I can't see the advantage (read and write
>are fileops; you can have them exactly the same for proc file and device).
>
>--------------------------------------------------------------------------------
>                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

