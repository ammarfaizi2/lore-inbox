Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319402AbSILBV2>; Wed, 11 Sep 2002 21:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319403AbSILBV2>; Wed, 11 Sep 2002 21:21:28 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:24588 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S319402AbSILBV1>; Wed, 11 Sep 2002 21:21:27 -0400
Date: Wed, 11 Sep 2002 18:25:52 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: the userspace side of driverfs
Message-ID: <20020912012552.GF10315@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <1031707119.1396.30.camel@entropy> <Pine.LNX.4.44.0209102122520.1057-100000@cherise.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209102122520.1057-100000@cherise.pdx.osdl.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2002 at 09:38:24PM -0700, Patrick Mochel wrote:
> I agree. There has been a lot of talk on this topic, but I don't think 
> much has gotten down on paper, though there might be some in the 
> archives...
> 
> The main ideal that we're shooting for is to have one ASCII value per
> file. The ASCII part is mandatory, but there will definitely be exceptions
> where we will have an array of or multiple values per file. We want to
> minimize those instances, though. Both for the sake of easy parsing, but
> also for easy formatting within the drivers.

Good so far.  When you have one value in a file the filename
tells you what it is.  What i don't want to see is more of
the multiple values in a file without labels or headings.
eg. /proc/sys/fs/inode-state (2.4.18):
	1792	133	0	0	0	0	0
I can't really trust documentation to keep up so the only
way i can be sure what these numbers are, is to look in the
kernel source.

Please, if you must have multiple values give them labels.

If it can only be 1 dimensional put one per line with a
label.  I don't care whether whether it 'label text:  value'
or 'label_text=value'  just as long as we are consistent
about the delimiters, capitalization (don't), whitespace and
underscore/dash.

If it needs to be 2 dimensional put the labels at the top as
a comment line (/^[;#]/d).  Using fixed width fields is asking
for trouble.  I prefer tab delimited but padding the fields
for alignment is OK as would be using tabs as long as we
agree on method and the labels don't have spaces.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
