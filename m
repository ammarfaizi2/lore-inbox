Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbVETFfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbVETFfw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 01:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbVETFfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 01:35:51 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:46744 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261351AbVETFfq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 01:35:46 -0400
Date: Fri, 20 May 2005 07:37:41 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: Re: kbuild: specifying phony targets?
Message-ID: <20050520053741.GB16699@mars.ravnborg.org>
References: <428B4CF5.1070507@ammasso.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428B4CF5.1070507@ammasso.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 09:11:01AM -0500, Timur Tabi wrote:
> I have a Makefile that works with 2.4 and 2.6 kernels.  On the 2.4 side, I 
> have a rule like this:
> 
> all: mytext ${TARGET_DIR} ${TARGET_DIR}/ccil.o
> 
> mytext:
>     @echo ${SOMETEXT}
> 
> This causes the text in variable SOMETEXT to be displayed right when the 
> build starts.
> 
> How do I do the same thing with kbuild?  Is there a way I can get a kbuild 
> makefile to run a phony target right at the beginning?

A phony target is not possible.
But use 'always' to tell kbuild what needs to be done.
Se also kbuild documentation: Documentation/kbuild/makefile.txt

	Sam
