Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279688AbRJYGQ1>; Thu, 25 Oct 2001 02:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279685AbRJYGQI>; Thu, 25 Oct 2001 02:16:08 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:28680 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S279680AbRJYGQH>;
	Thu, 25 Oct 2001 02:16:07 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200110250615.f9P6Fx0143825@saturn.cs.uml.edu>
Subject: Re: RFC - tree quotas for Linux (2.4.12, ext2)
To: pollard@tomcat.admin.navo.hpc.mil (Jesse Pollard)
Date: Thu, 25 Oct 2001 02:15:59 -0400 (EDT)
Cc: jas88@cam.ac.uk, riel@conectiva.com.br (Rik van Riel),
        jack@suse.cz (Jan Kara), neilb@cse.unsw.edu.au (Neil Brown),
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <200110241844.NAA32059@tomcat.admin.navo.hpc.mil> from "Jesse Pollard" at Oct 24, 2001 01:44:27 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard writes:

> There still remains the problem of hard links... They could be counted
> in two or more trees as long as two or more trees exist on one filesystem.

Obvious fix: prohibit hard links across tree quota boundries,
including any that might be created by a rename.

It is an admin error to enable tree quotas on trees that
have existing hard links.

While doing that, a sysctl or mount option to enable/disable hard
linking to other people's files would be nice. Default to stopping
the "feature" IMHO.

