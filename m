Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751804AbWIGDAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbWIGDAv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 23:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751807AbWIGDAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 23:00:51 -0400
Received: from web36713.mail.mud.yahoo.com ([209.191.85.47]:27231 "HELO
	web36713.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751804AbWIGDAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 23:00:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=f91OQzIXyvlv9HGSwLs40wQoJWdMRazz9uagPl+ofkR0oluU+IW7l7TqiZj4uUN9txbQpXo7FBD0LeXrv90jHxlt6qVDPfyE/fDlnOyslY1OnkWjANZmCyAco3iUyxj6e6hLG4SF+fGl/1H6CZIJztCcFw4yEMR6iISxMI7zAIw=  ;
Message-ID: <20060907030049.35159.qmail@web36713.mail.mud.yahoo.com>
Date: Wed, 6 Sep 2006 20:00:49 -0700 (PDT)
From: Alex Dubov <oakad@yahoo.com>
Subject: Re: Support for TI FlashMedia (pci id 104c:8033, 104c:803b) flash card readers
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44FE5668.4090000@drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As a temporal work-around to the timeout problem I've put the following in:
1. All data timeout values are multiplied by a fudge factor of 10 (this is still lower latency
than waiting for a software fall-back).
2. I've added a module option to disable hardware data timeout at all. This is how TI does it too
- command timeout is set to 64 clocks are data timeouts (if any) are captured by the slow software
handler. Card removal is signalled by its own interrupt, so the wait for data in this case will be
aborted anyway.
I haven't checked out your patch yet.

For a written blocks I'm now reporting the BUSY de-assert count rather than block counter value. I
hope this is a good idea.


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
