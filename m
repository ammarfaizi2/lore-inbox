Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132586AbREHOiO>; Tue, 8 May 2001 10:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132606AbREHOiF>; Tue, 8 May 2001 10:38:05 -0400
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:52090 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S132586AbREHOhx>; Tue, 8 May 2001 10:37:53 -0400
Date: Tue, 8 May 2001 09:37:47 -0500
From: Nathan Straz <nstraz@sgi.com>
To: Federico Edelman Anaya <fedelman@elsitio.com.ar>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: fs.file-max
Message-ID: <20010508093747.A1702@sgi.com>
Mail-Followup-To: Federico Edelman Anaya <fedelman@elsitio.com.ar>,
	Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <3AF7C46B.5655D1CA@elsitio.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <3AF7C46B.5655D1CA@elsitio.com.ar>; from fedelman@elsitio.com.ar on Tue, May 08, 2001 at 10:03:23AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2001 at 10:03:23AM +0000, Federico Edelman Anaya wrote:
> What can I do to test the FD limit? ... Because, the FD limit is set in
> /proc/sys/fs/file-max, sample:
> 
> echo "2048" > /proc/sys/fs/file-max
> ulimit -n 8192
> 
> In this case ... the FD limit = 8192 :( ... when the limit should be
> 2048?
> 
> I wrote a perl script for the test ... anybody known a "C" program for
> test the FD limit?

Hmm, we seem to be missing this test case from the Linux Test Project.
I see that dup03 exhausts all FDs and tests dup() for EMFILE.  You could
easily adapt that test case to a setrlimit() test case.  

-- 
Nate Straz                                              nstraz@sgi.com
sgi, inc                                           http://www.sgi.com/
Linux Test Project                         http://ltp.sourceforge.net/
