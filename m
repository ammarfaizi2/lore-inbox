Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261643AbULNUSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbULNUSa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 15:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbULNUS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 15:18:29 -0500
Received: from smtp.e7even.com ([83.151.192.5]:26320 "HELO smtp.e7even.com")
	by vger.kernel.org with SMTP id S261643AbULNUSC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 15:18:02 -0500
Subject: Re: file as a directory
From: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>
To: Hans Reiser <reiser@namesys.com>
Cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
In-Reply-To: <41BF21BC.1020809@namesys.com>
References: <200411301631.iAUGVT8h007823@laptop11.inf.utfsm.cl>
	 <41ACA7C9.1070001@namesys.com>
	 <1103043518.21728.159.camel@pear.st-and.ac.uk>
	 <41BF21BC.1020809@namesys.com>
Content-Type: text/plain
Message-Id: <1103059622.2999.17.camel@grape.st-and.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 14 Dec 2004 21:27:03 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-14 at 17:24, Hans Reiser wrote:
> Peter, I think you are right, though it might be useful to have the 
> default be dirname/..../glued and to allow users to link 
> dirname/..../filebody to 
> dirname/..../something_else_if_they_want_it_to_not_be_glued, and to have 
> dirname/..../filebody or whatever it is linked to be what they get if 
> they read the directory as a file.

Yes. I assume you mean that dirname in itself should always be
interpreted as dirname/..../glued, which by default would be a linked to
dirname/..../filebody, the latter being the file content, right?

Also, a pseudofile (e.g. dirname/..../structure ?) could be used to
specify how the files should be glued together. A simple question is,
for instance, what separators to use between the components, and what
ordering to use when putting the component objects together. (This
pseudofile could also determine more complicated ways of composing
objects.) 

The component objects themselves could be full objects, so they
themselves could have sub-components.
 Peter

