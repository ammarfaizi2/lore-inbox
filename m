Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269190AbTGJK1J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 06:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269192AbTGJK1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 06:27:09 -0400
Received: from angband.namesys.com ([212.16.7.85]:42880 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S269190AbTGJK1G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 06:27:06 -0400
Date: Thu, 10 Jul 2003 14:41:45 +0400
From: Oleg Drokin <green@namesys.com>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: "\"Nikita Danilov\" " <Nikita@Namesys.COM>, linux-kernel@vger.kernel.org
Subject: Re: Are "," and ".." in directory required?
Message-ID: <20030710104145.GA2858@namesys.com>
References: <16141.14720.980604.428130@laputa.namesys.com> <E19aYWH-00075R-00.arvidjaar-mail-ru@f25.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E19aYWH-00075R-00.arvidjaar-mail-ru@f25.mail.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Jul 10, 2003 at 02:19:21PM +0400, "Andrey Borzenkov"  wrote:
> > Enter empty directory. Remove it by rmdir() by another process. Now you
> > have a directory without dot and dotdot.
> It is not quite the same.
> bor@itsrm2% cd foo
> bor@itsrm2% sudo rmdir /tmp/foo
> bor@itsrm2% ls -la .
> .: No such file or directory

Well, this sequence of events is wrong.
You need to open it first, then remove it, and then do readdir (you still have filehandle to it).

Bye,
    Oleg
