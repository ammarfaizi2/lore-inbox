Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264934AbUAPAni (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 19:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264936AbUAPAnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 19:43:37 -0500
Received: from greendale.ukc.ac.uk ([129.12.21.13]:29927 "EHLO
	greendale.ukc.ac.uk") by vger.kernel.org with ESMTP id S264934AbUAPAng
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 19:43:36 -0500
To: Wes Janzen <superchkn@sbcglobal.net>
Cc: David Sanders <linux@sandersweb.net>,
       Haakon Riiser <haakon.riiser@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: NTFS disk usage on Linux 2.6
References: <20040115010210.GA570@s.chello.no>
	<200401151401.1764@sandersweb.net> <40071589.3070409@sbcglobal.net>
From: Adam Sampson <azz@us-lot.org>
Organization: Things I did not know at first I learned by doing twice.
Date: Fri, 16 Jan 2004 00:43:23 +0000
In-Reply-To: <40071589.3070409@sbcglobal.net> (Wes Janzen's message of "Thu,
 15 Jan 2004 16:34:49 -0600")
Message-ID: <y2a3cagoh90.fsf@cartman.at.fivegeeks.net>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-UKC-Mail-System: No virus detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wes Janzen <superchkn@sbcglobal.net> writes:

> I'm having the same issue on 2.6.0, this is with an 8.4G partition.

A similar problem shows up on 2.6.1 with smbfs, owing to silly block
counts:

$ ls -l 5glogo.avi 
-rw-rw-r--    1 1000     500        148640 2002-09-01 13:38 5glogo.avi
$ du -h 5glogo.avi 
512M    5glogo.avi
$ stat 5glogo.avi 
  File: `5glogo.avi'
  Size: 148640          Blocks: 1048576    IO Block: 4096   regular file
...

Reported to the smbfs maintainer a while back.

-- 
Adam Sampson <azz@us-lot.org>                        <http://offog.org/>
