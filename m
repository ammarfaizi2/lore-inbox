Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281846AbRK1Ce5>; Tue, 27 Nov 2001 21:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283009AbRK1Cer>; Tue, 27 Nov 2001 21:34:47 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:24049
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S281846AbRK1Ceg>; Tue, 27 Nov 2001 21:34:36 -0500
Date: Tue, 27 Nov 2001 18:34:29 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Unresponiveness of 2.4.16
Message-ID: <20011127183429.B862@mikef-linux.matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20011128013129Z281843-17408+21534@vger.kernel.org> <3C044855.3CF2DCA3@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C044855.3CF2DCA3@zip.com.au>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2001 at 06:13:41PM -0800, Andrew Morton wrote:
> Dieter N?tzel wrote:
> > Don't forget to tune max-readahead.
> 
> Yes.  Readahead is fairly critical and there may be additional fixes
> needed in this area.
> 
> Someone recently added the /proc/sys/vm/max_readahead (?) tunable.
> Beware of this.  It only works for device drivers which do not
> populate their own readhead table.  For IDE, it *looks* like
> it works, but it doesn't.   For IDE, the only way to alter VM
> readahead is via
> 
> 	echo file_readahead:N > /proc/ide/ide0/hda/settings
> 
> where N is in kilobytes in 2.4.16 kernels.  

Any idea which drivers it will/won't work on?  ie, "almost all ide" or
"almost none of the ide driers"?

>In earlier kernels
> it's kilopages (!).

Isn't this part of the max-readahead patch?

Does /proc/sys/vm/max_readahead affect scsi in any way?

What layer does /proc/sys/vm/max_readahead affect?  Block? FS?

MF
