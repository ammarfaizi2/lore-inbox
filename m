Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVCGN4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVCGN4H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 08:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVCGN4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 08:56:07 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:62374 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261164AbVCGNz5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 08:55:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=e66QhPaZ4BvPgupziiqW856QDaxJsfnpkAxrBq4BfkVrDOCnzqvK/N+vuInZ9kvdz9XxrvruIAiSvI0QSRmsyrZmijkzWjWjOkfov394BKjkNICWQXbW6hQpMFMrLXo3IMIu2GvD0C0Td63pLJOlBwN39WLjuGaGv+S0z7Bu4HU=
Message-ID: <d120d500050307055522415fb3@mail.gmail.com>
Date: Mon, 7 Mar 2005 08:55:56 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Henrik Persson <root@fulhack.info>
Subject: Re: Touchpad "tapping" changes in 2.6.11?
Cc: dtor@mail.ru, linux-kernel@vger.kernel.org
In-Reply-To: <422C539A.4040407@fulhack.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <422C539A.4040407@fulhack.info>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Mar 2005 14:14:02 +0100, Henrik Persson <root@fulhack.info> wrote:
> Hi there.
> 
> I noticed that the ALPS driver was added to 2.6.11, a thing that alot of
> people probably like, but since my touchpad (Acer Aspire 1300XV) worked
> perfectly before (like, 2.6.10) and now the ALPS driver disables
> 'hardware tapping', wich makes it hard to tap. I commented out the
> disable-tapping bits in alps.c and now it's working like a charm again.
> 

Hi,

Could you please try 2.6.11-mm1. It has bunch of Peter Osterlund's
patches that shoudl improve the situation with tapping.

> Maybe the hardware tapping-thing should be configurable via some boot or
> config option?
> 

After all quirks are worked out I think tapping will be controlled via
mousedev.tap_time parameter when using legacy interfaces
(dev/input/mouseX) and Peter's X driver when using native event
interface.

-- 
Dmitry
