Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293619AbSCAS6c>; Fri, 1 Mar 2002 13:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293601AbSCAS6X>; Fri, 1 Mar 2002 13:58:23 -0500
Received: from rover.mkp.net ([209.217.122.9]:50193 "EHLO rover")
	by vger.kernel.org with ESMTP id <S293527AbSCAS6Q>;
	Fri, 1 Mar 2002 13:58:16 -0500
To: svetljo <galia@st-peter.stw.uni-erlangen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: REPOST : linux-2.5.5-xfs-dj1+ 2.5.5-dj2  (raid0_make_request bug)
From: "Martin K. Petersen" <mkp@mkp.net>
Organization: mkp.net
In-Reply-To: <3C7FC4A5.7050907@st-peter.stw.uni-erlangen.de>
Date: 01 Mar 2002 13:58:12 -0500
In-Reply-To: <3C7FC4A5.7050907@st-peter.stw.uni-erlangen.de>
Message-ID: <yq1d6yojet7.fsf@austin.mkp.net>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Civil Service)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> raid0_make_request bug: can't convert block across chunks or bigger
> than 16k 23610115 64

The RAID0 code does not support request splitting and can't handle the
big I/Os XFS throws at it.

I am currently porting my kiobuf request splitter code to biobufs to
deal with this.

-- 
Martin K. Petersen, Principal Linux Consultant, Linuxcare, Inc.
mkp@linuxcare.com, http://www.linuxcare.com/
SGI XFS for Linux Developer, http://oss.sgi.com/projects/xfs/

