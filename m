Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285305AbRLSOwm>; Wed, 19 Dec 2001 09:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285308AbRLSOwc>; Wed, 19 Dec 2001 09:52:32 -0500
Received: from smtp01.fields.gol.com ([203.216.5.131]:17929 "EHLO
	smtp01.fields.gol.com") by vger.kernel.org with ESMTP
	id <S285305AbRLSOwQ>; Wed, 19 Dec 2001 09:52:16 -0500
Date: Wed, 19 Dec 2001 23:52:03 +0900
From: Masaru Kawashima <masaruk@gol.com>
To: Oleg Drokin <green@namesys.com>
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com, chris@suse.de
Subject: Re: [reiserfs-list] reiserfs remount problem (Re: Linux 2.4.17-rc2)
Message-Id: <20011219235203.322a02e3.masaruk@gol.com>
In-Reply-To: <20011219172644.A28692@namesys.com>
In-Reply-To: <Pine.LNX.4.21.0112181824020.4821-100000@freak.distro.conectiva>
	<20011219230812.049c2c5c.masaruk@gol.com>
	<20011219172644.A28692@namesys.com>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: "3UD?v?v'zSkYncgSd/w8_XIZeI<6UVWiR|O`MK|4r<R13hW),-w;.4EGFl]M=i9H/_&}\1 sKHvNj7@@1vM\{'-2s{Os@$kL9Tv_XHO2:2/DJSC5c\k:|=g{~sn(jc~EDth4,/}3.O0g8X/\5bhi2 ^{gjQFxH`RH{?z"Gqh5Kt^n%/v],ZNO"zO~Re
X-Operating-System: Kondara MNU/Linux 2.0
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Abuse-Complaints: abuse@gol.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 19 Dec 2001 17:26:44 +0300
Oleg Drokin <green@namesys.com> wrote:

> Hello!
> 
> On Wed, Dec 19, 2001 at 11:08:12PM +0900, Masaru Kawashima wrote:
> 
> > > - Reiserfs fixes				(Oleg Drokin/Chris Mason)
> 
> > There is still reiserfs remount problem with 2.4.17-rc2.
> Hmmm.
> Few things needs to be verified:
> Is your reiserfs root partition 3.5 or 3.6 format? (can be checked in /proc/fs/reiserfs/.../version

It's 3.6 format.

  # cat /proc/fs/reiserfs/version 
  ReiserFS version 3.6.25 [built into kernel]
  # cat /proc/fs/reiserfs/*/version
  new format      with checks off
  new format      with checks off
  new format      with checks off
  new format      with checks off
  new format      with checks off

> Try to boot of different media (rescue disk/CD) and run resiserfsck on your root partition,
> is there any errors? 

I've tried reiserfsck with booting from spare root partition
formatted with ext3.  But there was no errors.

> Is your root partition big?

Yes.  It's 85GB.  And it's on a software raid (raid0) partition.

> I want to look at it is that's possible.
> At least at the metadata (reiserfsutils contains tools to extract metadata from disk drive,
> if you'd extract such metadata and send it to me before you run reiserfsck - that would be great)

-- 
Masaru Kawashima <masaruk@gol.com>
