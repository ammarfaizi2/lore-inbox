Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290790AbSARTkz>; Fri, 18 Jan 2002 14:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290791AbSARTkp>; Fri, 18 Jan 2002 14:40:45 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37133 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290790AbSARTka>; Fri, 18 Jan 2002 14:40:30 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 2.4.17:Increase number of anonymous filesystems beyond 256?
Date: 18 Jan 2002 11:40:12 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a29tms$s9v$1@cesium.transmeta.com>
In-Reply-To: <mailman.1011275640.16596.linux-kernel2news@redhat.com> <200201171855.g0HIt1314492@devserv.devel.redhat.com> <200201181212.g0ICCGq14563@bliss.uni-koblenz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200201181212.g0ICCGq14563@bliss.uni-koblenz.de>
By author:    Rainer Krienke <krienke@uni-koblenz.de>
In newsgroup: linux.dev.kernel
> 
> Now think of a setup where no user directory mounts are configured but the 
> whole directory of a NFS server with many users is exported. Of course this 
> makes things easyer for the NFS-system since only one mount is needed but on 
> the client you need to create link trees or something similar so the user 
> still can access his home under /home/<user> and not something like 
> /home/server1/<user>. Moreover even if you create link trees when you issue 
> commands like pwd you see the real path (eg /server1/<user>) instead of the 
> logical (/home/<user>). Such paths are soon written into scripts etc, so that 
> if the user is moved sometime later  things will be broken. 
> You simply loose a layer of abstraction if you do not mount the users dir 
> directly. The only other solution I know of would be amd. Amd automatically 
> places a link. But since we come from the sun world, we simply uses suns 
> automounter and there were no problems up to now. 
> 

This can easily be resolved with vfsbinds.  Even Sun has a specific
syntax in their automounter to deal with this
(server:common_root:tail).  If I ever do another autofs v3 release I
will probably try to incorporate that via vfsbinds.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
