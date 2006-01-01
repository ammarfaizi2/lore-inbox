Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWAALSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWAALSa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 06:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWAALSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 06:18:30 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:31173 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1750791AbWAALSa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 06:18:30 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Marc Giger <gigerstyle@gmx.ch>
cc: Kalin KOZHUHAROV <kalin@thinrope.net>, linux-kernel@vger.kernel.org
Subject: Re: Howto set kernel makefile to use particular gcc 
In-reply-to: Your message of "Sun, 01 Jan 2006 12:13:03 BST."
             <20060101121303.488e634b@vaio.gigerstyle.ch> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 01 Jan 2006 22:18:27 +1100
Message-ID: <23377.1136114307@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Giger (on Sun, 1 Jan 2006 12:13:03 +0100) wrote:
>Why would you "hardwire" it?
>#export CC="distcc"
>should do it.

Doubt it.  From 'info make', Node: Environment.

   Variables in `make' can come from the environment in which `make' is
  run.  Every environment variable that `make' sees when it starts up
  is transformed into a `make' variable with the same name and value.
  But an explicit assignment in the makefile, or with a command
  argument, overrides the environment.  (If the `-e' flag is specified,
  then values from the environment override assignments in the
  makefile.  *Note Summary of Options: Options Summary.  But this is
  not recommended practice.)

The kernel Makefile explicitly sets CC which overrides the environment
value, but does not override a command line definition of CC.  IOW, do
not reply on environment variables always working with make.

