Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267481AbTBLQt2>; Wed, 12 Feb 2003 11:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267487AbTBLQt2>; Wed, 12 Feb 2003 11:49:28 -0500
Received: from imr1.ericy.com ([208.237.135.240]:21460 "EHLO imr1.ericy.com")
	by vger.kernel.org with ESMTP id <S267481AbTBLQt1>;
	Wed, 12 Feb 2003 11:49:27 -0500
Message-ID: <7B2A7784F4B7F0409947481F3F3FEF8305CC954F@eammlex037.lmc.ericsson.se>
From: "Makan Pourzandi (LMC)" <Makan.Pourzandi@ericsson.ca>
To: "'Christoph Hellwig'" <hch@infradead.org>,
       "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Cc: greg@kroah.com, linux-security-module@wirex.com,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: RE: [BK PATCH] LSM changes for 2.5.59
Date: Wed, 12 Feb 2003 11:58:52 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > I'm very serious about submitting a patch to Linus to 
> remove all hooks not
> > > used by any intree module once 2.6.0-test.
> > 
> > Any idea on how much time that gives us (to rework SELinux 
> and submit
> > it)?
> 

Hi, 

My comments are from user of LSM point of view and not one of its designers. Actually, we have been using LSM for now about a year to develop our own security module in DSI project (security for clustered server, http://sourceforge.net/projects/disec). 

I believe that one major advantage of LSM is that it avoids the one size fits all approach. LSM allows to different people to come up with different mechanisms to implement security according to their needs. 
And different Linux users have different needs. For example in DSI project, we used LSM to implement our own security approach for clustered servers. For example, having tight restrictions on response time, we rather concentrate on performance impact of security and distributed access control inside a cluster than file access control (running mainly diskless machines). 
I believe this is very acceptable, because it allows the user to choose the security module that fits best its needs. The security needs are not the same for military/banking/telecom/gaming/... businesses. And till the moment that we have a config tool (file or else) that can allow these people to configure fine grained access control according to their needs (for example like how we configure iptables), I believe that LSM is necessary to give these people a chance of developing their own solution. 


Further more, I believe that LSM encourages the developers in the community to take initiatives related to security in Linux. This way, it helps developing different security approaches. This at the end, even if we choose to go with only one approach and drop others,  will help the diversity of existing solutions and the possibility of choosing among a set of solutions (hopefully the best one will be chosen). IMHO, to let people be able to come up with different security approaches, we have
to let LSM be part of the kernel in order to encourage people to
develop their approach.

That was my 2 cents. 

Regards, 
Makan Pourzandi 
-------------------------------------------------------
Makan Pourzandi            
Ericsson Research Canada
http://sourceforge.net/projects/disec/      
-------------------------------------------------------         

This email does not represent or express the opinions of Ericsson
Corporation.

