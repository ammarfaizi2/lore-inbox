Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264449AbTF2U5y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 16:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264279AbTF2U5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 16:57:53 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:50359 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S265083AbTF2Uye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 16:54:34 -0400
Message-ID: <3EFF5551.1000600@nortelnetworks.com>
Date: Sun, 29 Jun 2003 17:08:33 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: rmoser <mlmoser@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: File System conversion -- ideas
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk> <20030629132807.GA25170@mail.jlokier.co.uk> <3EFEEF8F.7050607@post.pl> <20030629192847.GB26258@mail.jlokier.co.uk> <20030629194215.GG27348@parcelfarce.linux.theplanet.co.uk> <200306291545410600.02136814@smtp.comcast.net> <20030629200020.GH27348@parcelfarce.linux.theplanet.co.uk> <200306291629450990.023BC35E@smtp.comcast.net> <20030629205150.GK27348@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:

> The *SHOW* *THEM*.  You keep repeating that it's simple.  Fine, show that
> it can be done.  Then we can start talking about the rest - until you can
> demonstrate (as in, show the working code) that does what you call simple,
> there is no point in going any further.
> 
> _That_ is the point of contention.  And no, saying the word "atom" does
> not count as proof of feasibility.  Show how to map metadata between different
> filesystem types.  Hell, show that you know what types of metadata are there.


Presumably the in-kernel metadata would need to be a superset of all of 
the different metadata stored by all the different supported filesystems.

It then needs two converters for each filesystem, to/from the metadata 
format. When you hit a new filesystem that your metadata doesn't 
support, you extend that metadata.

Of course, you're screwed if the new filesystem is sufficiently odd that 
it doesn't map nicely to the metadata organization.

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

