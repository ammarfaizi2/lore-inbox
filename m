Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314557AbSEUNe0>; Tue, 21 May 2002 09:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314584AbSEUNeZ>; Tue, 21 May 2002 09:34:25 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:46603 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S314557AbSEUNeX>; Tue, 21 May 2002 09:34:23 -0400
Date: Tue, 21 May 2002 08:34:08 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200205211334.IAA21528@tomcat.admin.navo.hpc.mil>
To: dax@gurulabs.com, Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Subject: Re: suid bit on directories
cc: linux-kernel@vger.kernel.org,
        "michael@hostsharing.net" <michael@hostsharing.net>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dax Kelson <dax@gurulabs.com>:
> 
> On Mon, 20 May 2002, Jesse Pollard wrote:
> 
> > That is NOT wrong. The files belong to the server. Not a user. I've been
> > running a server that way for years.
> 
> This is insecure.
> 
> A user has a defined security context.  If the user can create code that 
> is then executed in a different security context (user httpd/nobody), then 
> you've got a potential problem.  If you have multiple users who can 
> create code that executes in the *same* security context, you have a 
> recipe for disaster.

correct.

> user1 can write a web app the delete/modifies the web app, or web app 
> created files of user2.

Exactly what you get when the owner is hidden. Whose app got executed
that created/destroyed someone elses files? What files were created?

It all runs under the web server account... but the results are owned by
the attacked user so it looks like the user did it. Anything a CGI can
create, a CGI can execute or cause to be executed.

If you want a secured web server, DON'T let users create CGI. and don't
give the CGI the capability to execute other programs either. And this
is where compartmentalization comes into play.

All you know is that maybe the attack was via a web server. But you can't tell.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
