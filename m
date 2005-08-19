Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932494AbVHSLer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbVHSLer (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 07:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbVHSLer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 07:34:47 -0400
Received: from natfrord.rzone.de ([81.169.145.161]:7358 "EHLO
	natfrord.rzone.de") by vger.kernel.org with ESMTP id S932494AbVHSLeq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 07:34:46 -0400
From: Stefan Rompf <stefan@loplof.de>
To: Dave Hansen <dave@sr71.net>, linux-kernel@vger.kernel.org
Subject: Re: [Hdaps-devel] Re: HDAPS, Need to park the head for real
Date: Fri, 19 Aug 2005 13:36:36 +0200
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508191336.36832.stefan@loplof.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:

> In reality, that probably means a statically compiled daemon that
> mlock()s itself, and any structures that it will need.  It _might_ even
> need to keep an open file descriptor on the "frozen" file.  Because, in
> theory, that file could be written out to the sysfs backing store.

with such a hassle to make the parking API available, assure that the head 
parking daemon is not swapped out, can access the filedescriptor, has a 
priority high enough to start immediatly when needed, wouldn't that qualify 
for running in kernel space?

Stefan
