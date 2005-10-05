Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965093AbVJEJYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965093AbVJEJYN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 05:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965094AbVJEJYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 05:24:13 -0400
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:44513 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S965093AbVJEJYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 05:24:13 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17219.39868.493728.141642@gargle.gargle.HOWL>
Date: Wed, 5 Oct 2005 13:24:12 +0400
To: Marc Perkel <marc@perkel.com>
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Newsgroups: gmane.linux.kernel
In-Reply-To: <4343694F.5000709@perkel.com>
References: <20051002204703.GG6290@lkcl.net>
	<4342DC4D.8090908@perkel.com>
	<200510050122.39307.dhazelton@enter.net>
	<4343694F.5000709@perkel.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Perkel writes:

[...]

 > Right - that's Unix "inside the box" thinking. The idea is to make the 
 > operating system smarter so that the user doesn't have to deal with 
 > what's computer friendly - but reather what makes sense to the user. 
 >  From a user's perspective if you have not rights to access a file then 
 > why should you be allowed to delete it?

Because in Unix a name is not an attribute of a file.

Files are objects that you read, write and truncate. They are
represented by inodes.

Separately from that, there is an indexing structure: directory
tree. Directories map symbolical names to inodes. Obviously, adding a
reference to an index, or removing it from one requires access
permission to the _index_ rather then to the object being referenced.

That two-level model of files and indexing on top of them is essential
to Unix due to the flexibility and conceptual economy it provides.

 > 
 > Now - the idea is to create choice. If you need to emulate Unix nehavior 
 > for compatibility that's fine. But I would migrate away from that into a 
 > permissions paradygme that worked like Netware.

And there are people believing that ITS (or VMS, or <insert your first
passion here>...) set the standard to follow. :-)

[...]

 > 
 > So - the thread is about the future so I say - time to fix Unix.

One thing is clear: it's too late to fix Netware. Why should Unix
emulate its lethal defects?

Nikita.
