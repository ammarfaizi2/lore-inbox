Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316495AbSEUD2U>; Mon, 20 May 2002 23:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316496AbSEUD2T>; Mon, 20 May 2002 23:28:19 -0400
Received: from w007.z208177138.sjc-ca.dsl.cnc.net ([208.177.141.7]:20909 "HELO
	mail.gurulabs.com") by vger.kernel.org with SMTP id <S316495AbSEUD2S>;
	Mon, 20 May 2002 23:28:18 -0400
Date: Mon, 20 May 2002 21:28:18 -0600 (MDT)
From: Dax Kelson <dax@gurulabs.com>
X-X-Sender: dkelson@localhost.localdomain
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
cc: linux-kernel@vger.kernel.org,
        "michael@hostsharing.net" <michael@hostsharing.net>
Subject: Re: suid bit on directories
In-Reply-To: <200205201403.JAA08246@tomcat.admin.navo.hpc.mil>
Message-ID: <Pine.LNX.4.44.0205202122260.24416-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 May 2002, Jesse Pollard wrote:

> > > No. You loose the fact that the file was NOT created by the user.
> > 
> > the user in my example above would be wwwrun or httpd - and that does not
> > make any sense at all! It would make much more sense if the new files
> > belonged to the owner of the directory, who is the one who owns the
> > virtual host.
> 
> You can't tell who the user is. ANY user would be able to do that.

Bzzzt.  Only if the permissions permitted it.


Example 1:

/home/bob/public_html

public_html  is user/group  bob/httpd

the perms are 2770

============================

Example 2:

All users on the system have a primary or secondary group "users"

/home/bob   user/group  bob/users

perms are 701

This explictly denies "users", yet allows Apache in (since it is running 
as httpd).


