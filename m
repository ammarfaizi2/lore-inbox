Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291738AbSBNQEX>; Thu, 14 Feb 2002 11:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291741AbSBNQEO>; Thu, 14 Feb 2002 11:04:14 -0500
Received: from fsgi03.fnal.gov ([131.225.68.48]:317 "EHLO fsgi03.fnal.gov")
	by vger.kernel.org with ESMTP id <S291738AbSBNQEA>;
	Thu, 14 Feb 2002 11:04:00 -0500
Date: Thu, 14 Feb 2002 10:03:57 -0600
From: Alexander Moibenko <moibenko@fnal.gov>
To: <linux-kernel@vger.kernel.org>
Subject: fsync delays for a long time.
Message-ID: <Pine.SGI.4.31.0202140951330.3076325-100000@fsgi03.fnal.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
we are using gdbm in our application. It has been noticed that whenever
a disk intesive job is running our application hangs for a very long time.
This is the scenario I'm getting in trouble with:
run my gdbm application and bonnie test on the same device.
When gdbm comes to the point when it calls fsync it delays for a long
time.
The time depends on the CPU and disk speed, but always is intolerably big:
few tens of sec - to minutes.
It does not seem to depend on the size of the DB.
Application runs on the machines with 2.2.x kernel.
Had anyone seen the same problem?
I've seen a discussion about a bad performance of SCSI versus IDE drives
with mySQL on this list. But we tried it on both with the same (bad)
result. IDE is even worse in our case. In the discussion it was also said
that fsync for 2.4.x is modified. But does it fix a problem?
Thanks in advance for comments and suggestions.

--------------------------------------------------------------------------
Alexander N. Moibenko, Integrated Systems Development, CD, Fermilab
email: moibenko@fnal.fnal.gov
--------------------------------------------------------------------------

