Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbWBGRhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWBGRhT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 12:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWBGRhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 12:37:19 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:38031 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932187AbWBGRhR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 12:37:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hJCVtAAais+7tCNV/ayNL/IHb1GMuuAQQuhVA/fkw46R+0fk9mh3NBcYnpNyy3mJXLF8bo0DtIZ7+D/LMH3/wv+gU2c2th5OrgNsqOPe7iLVVEa2NNIzGO6oRKnKtUuwDsv2zmyU6hl7a0Fr1AdxOIeX5Ubmsyz/vx6hheOXpvk=
Message-ID: <a36005b50602070937h60e35294q1dbef2c21f2fb50d@mail.gmail.com>
Date: Tue, 7 Feb 2006 09:37:13 -0800
From: Ulrich Drepper <drepper@gmail.com>
To: Jeff Dike <jdike@addtoit.com>
Subject: Re: [PATCH 2/8] UML - Define jmpbuf access constants
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
In-Reply-To: <200602070223.k172NpJa009654@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200602070223.k172NpJa009654@ccure.user-mode-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/06, Jeff Dike <jdike@addtoit.com> wrote:
> With newer libcs, the JB_* macros (which we shouldn't be using anyway,
> probably) go away.

I assume you have your own setjmp implementation and are not using the
libc version?

If you don't then there is a problem.  There is a good reason why the
constants are removed: you couldn't use the values anyway.  Your don't
have the information to "decrypt" them.  If you just used the values
and implemented the function yourself, fine.
