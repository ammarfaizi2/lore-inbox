Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316499AbSEUDtg>; Mon, 20 May 2002 23:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316500AbSEUDtf>; Mon, 20 May 2002 23:49:35 -0400
Received: from w007.z208177141.sjc-ca.dsl.cnc.net ([208.177.141.7]:42157 "HELO
	mail.gurulabs.com") by vger.kernel.org with SMTP id <S316499AbSEUDtf>;
	Mon, 20 May 2002 23:49:35 -0400
Date: Mon, 20 May 2002 21:49:34 -0600 (MDT)
From: Dax Kelson <dax@gurulabs.com>
X-X-Sender: dkelson@localhost.localdomain
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
cc: "michael@hostsharing.net" <michael@hostsharing.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: suid bit on directories
In-Reply-To: <200205201928.OAA13328@tomcat.admin.navo.hpc.mil>
Message-ID: <Pine.LNX.4.44.0205202139220.24416-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 May 2002, Jesse Pollard wrote:

> That is NOT wrong. The files belong to the server. Not a user. I've been
> running a server that way for years.

This is insecure.

A user has a defined security context.  If the user can create code that 
is then executed in a different security context (user httpd/nobody), then 
you've got a potential problem.  If you have multiple users who can 
create code that executes in the *same* security context, you have a 
recipe for disaster.

user1 can write a web app the delete/modifies the web app, or web app 
created files of user2.

Dax Kelson
Guru Labs

