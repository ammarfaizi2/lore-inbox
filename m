Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbTEMSLc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 14:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbTEMSL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 14:11:27 -0400
Received: from mrelay1.cc.umr.edu ([131.151.1.120]:64434 "EHLO smtp.umr.edu")
	by vger.kernel.org with ESMTP id S261706AbTEMSLI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 14:11:08 -0400
x-mimeole: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [OpenAFS-devel] Re: [PATCH] in-core AFS multiplexor and PAG support
Date: Tue, 13 May 2003 13:23:48 -0500
Message-ID: <B578DAA4FD40684793C953B491D4879174D3B8@umr-mail7.umr.edu>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [OpenAFS-devel] Re: [PATCH] in-core AFS multiplexor and PAG support
Thread-Index: AcMZersqMuxI73onRtGLA3LFXRonyQAAeh1w
From: "Neulinger, Nathan" <nneul@umr.edu>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Linus Torvalds" <torvalds@transmeta.com>
Cc: "David Howells" <dhowells@redhat.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <linux-fsdevel@vger.kernel.org>, <openafs-devel@openafs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, handles it fine and used quite frequently, just have to set a new
pag (done automatically if it's really a new login and not just a new
xterm, or can start a command with 'pagsh' command to start it in a new
pag).

-- Nathan

------------------------------------------------------------
Nathan Neulinger                       EMail:  nneul@umr.edu
University of Missouri - Rolla         Phone: (573) 341-4841
Computing Services                       Fax: (573) 341-4216


> -----Original Message-----
> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk] 
> Sent: Tuesday, May 13, 2003 10:44 AM
> To: Linus Torvalds
> Cc: David Howells; Linux Kernel Mailing List; 
> linux-fsdevel@vger.kernel.org; openafs-devel@openafs.org
> Subject: [OpenAFS-devel] Re: [PATCH] in-core AFS multiplexor 
> and PAG support
> 
> 
> On Maw, 2003-05-13 at 16:52, Linus Torvalds wrote:
> > I think the code looks pretty horrible, but I think we'll 
> need something
> > like this to keep track of keys. However, I'm not sure we 
> should make this
> > a new structure - I think we should make the current 
> "tsk->user" thing
> > _be_ the "PAG". 
> 
> With something like SELinux a PAG may belong to a role not to a user
> even though other limits like processes probably belong to 
> the user as a
> whole. 
> 
> How does AFS currently handle this, can two logins of the 
> same user have
> seperate PAGs ?
> 
> _______________________________________________
> OpenAFS-devel mailing list
> OpenAFS-devel@openafs.org
> https://lists.openafs.org/mailman/listinfo/openafs-devel
> 
