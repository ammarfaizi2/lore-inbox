Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266153AbUGZW6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266153AbUGZW6v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 18:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266154AbUGZW6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 18:58:51 -0400
Received: from fmr06.intel.com ([134.134.136.7]:51343 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S266153AbUGZW6s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 18:58:48 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch] kernel events layer
Date: Mon, 26 Jul 2004 15:58:26 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A6EBFB9@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] kernel events layer
Thread-Index: AcRzH9ut5eApZ763QF6qo/o9Il9cRQAQiOzg
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Robert Love" <rml@ximian.com>
Cc: "Andrew Morton" <akpm@osdl.org>, <cw@f00f.org>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 Jul 2004 22:58:27.0013 (UTC) FILETIME=[0FACE750:01C47364]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Robert Love [mailto:rml@ximian.com]
>
> > methinks: if the message is related to some object that has a kobject
> > representation, use it. If not, come up with one on a case by case
> > basis [now this is the difficult one--is where it'd be difficult to
> > keep things on leash].
> 
> That introduces two orthogonal name spaces, and that really doesn't cut
> it.
> 
> If Greg can come up with a solution for using kobjects, I am all for
> that - that would be great - but I really do not see kobject paths
> working out.  I think the best we have is the file path in the tree.

Agreed -- I guess what I am looking for is a regular way to link the 
instance of the object (if any) that caused the message, so it is easier 
to take action.

For a silly example, IDE, I want to know which hard drive had a read 
error; knowing that it came from drivers/ide/ide-disk.c is useful, but
quite limited; it doesn't tell me which drive I need to babysit and 
maybe swap. Certainly the message can print that information as part of
the text, but chances up we'll end up with something like printk again
if following that path.

Ok, I did my share of non-very-constructive criticism already--shutting up :)

Thx,

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault) 
