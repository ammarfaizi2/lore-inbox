Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315379AbSGXJAu>; Wed, 24 Jul 2002 05:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315451AbSGXJAu>; Wed, 24 Jul 2002 05:00:50 -0400
Received: from conductor.synapse.net ([199.84.54.18]:53257 "HELO
	conductor.synapse.net") by vger.kernel.org with SMTP
	id <S315293AbSGXJAm>; Wed, 24 Jul 2002 05:00:42 -0400
Content-Type: text/plain; charset=US-ASCII
From: "D.A.M. Revok" <marvin@synapse.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Compile Bogons in 2.4.19-rc3 with Caldera OpenLinux 3.1's patched 2.95.2
Date: Wed, 24 Jul 2002 05:03:52 -0400
X-Mailer: KMail [version 1.3.1]
References: <20020724082557Z318273-685+17059@vger.kernel.org> <20020724084749.GC15043@dreams.soze.net>
In-Reply-To: <20020724084749.GC15043@dreams.soze.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020724090042Z315293-686+2972@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[root@Starhawk marvin]# cd /usr/src/linux/include
[root@Starhawk include]# ll
lrwxrwxrwx    1 root     root            8 Jul 24 03:23 asm -> asm-i386

it already /is/ such a symlink.  The /usr/include/asm, though...
Oh, fucking great, /usr/include/asm /isn't/ a symlink to 
/usr/src/linux/include/asm, it's its own directory.

( can we say self-inconsistency? )

Interestingly, NONE of these ( listed ) files exist in either location
( one being the stock-kernel-sources and the other being Caldera's ( though 
possibly I scrambled something over the past year ) /usr/include/asm 
?DIRECTORY ( rather than symlink ) ).

Perhaps if it works-for-you then you've got the files in your 
/usr/include/asm directory since they aren't in the stock kernel?

On Wed  24 July, 2002 04:47, you wrote:
> At 2002-07-24 08:29 +0000, D. A. M. Revok wrote:
> > *au1000_gpio.c:41: asm/au1000.h: No such file or directory
> > *au1000_gpio.c:42: asm/au1000_gpio.h: No such file or directory
> > *i2c-ite.h:36: asm/it8172/it8172.h: No such file or directory
> > *rtc.c:27: asm/machdep.h: No such file or directory
> > *rtc.c:29: asm/time.h: No such file or directory
the closest match in /usr/src/linux/include/asm-i386 is
timex.h

> Your asm/ symlink got trashed somehow.
>
> either /usr/include/asm or /usr/src/linux/include/asm (or both) needs
> to be symlinked to /usr/src/linux/include/asm-i386 (or whatever)
