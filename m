Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129440AbRCBTe6>; Fri, 2 Mar 2001 14:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129438AbRCBTes>; Fri, 2 Mar 2001 14:34:48 -0500
Received: from [209.102.105.34] ([209.102.105.34]:50956 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S129440AbRCBTe2>;
	Fri, 2 Mar 2001 14:34:28 -0500
Date: Fri, 2 Mar 2001 11:33:45 -0800
From: Tim Wright <timw@splhi.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Alexander Viro <viro@math.psu.edu>, "H. Peter Anvin" <hpa@transmeta.com>,
        Bill Crawford <billc@netcomuk.co.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Daniel Phillips <phillips@innominate.de>
Subject: Re: Hashing and directories
Message-ID: <20010302113345.B1438@kochanski.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: Pavel Machek <pavel@suse.cz>,
	Alexander Viro <viro@math.psu.edu>,
	"H. Peter Anvin" <hpa@transmeta.com>,
	Bill Crawford <billc@netcomuk.co.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Daniel Phillips <phillips@innominate.de>
In-Reply-To: <3A9EB984.C1F7E499@transmeta.com> <Pine.GSO.4.21.0103011608360.11577-100000@weyl.math.psu.edu> <20010302100410.I15061@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010302100410.I15061@atrey.karlin.mff.cuni.cz>; from pavel@suse.cz on Fri, Mar 02, 2001 at 10:04:10AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2001 at 10:04:10AM +0100, Pavel Machek wrote:
> 
> xargs is very ugly. I want to rm 12*. Just plain "rm 12*". *Not* "find
> . -name "12*" | xargs rm, which has terrible issues with files names
> 
> "xyzzy"
> "bla"
> "xyzzy bla"
> "12 xyzzy bla"
> 

Getting a bit OffTopic(TM) here, but that's why the GNU versions of the tools
wisely added options to output '\0' rather than '\n' as a separator for the
data i.e.
find . -name '12*' -print0 | xargs -0 rm
does exactly what you want it to - no surprises.

The point about arbitrary limits, is, however well taken. The fact that the
space for exec args and environment historically was static and of a fixed
size is not a good reason to perpetuate the limitation.

Tim

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
Interested in Linux scalability ? Look at http://lse.sourceforge.net/
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
