Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261847AbVGaR76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbVGaR76 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 13:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbVGaR76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 13:59:58 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:64958 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261847AbVGaR75 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 13:59:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o8cBLb5kxbt4GeaRSD7FD2meox/prOfeb3DgRaepeNsep+T5UiuZiRo4K9C6nUjpzUxZRbHlIqATEOQGlx6rqbPeiGUiSJMg2gKT1yK7k4Bqj64YOK3ulDCtkVQQ0F8SC+IwS3YIgBv9M2fx0Wr06X9hA6uwWUgJh/4CRS2IMvg=
Message-ID: <a36005b5050731105924a2f1e5@mail.gmail.com>
Date: Sun, 31 Jul 2005 10:59:57 -0700
From: Ulrich Drepper <drepper@gmail.com>
Reply-To: Ulrich Drepper <drepper@gmail.com>
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Subject: Re: sigwait() breaks when straced
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <E1Dz15m-0000sO-Qx@approximate.corpus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <E1Dz15m-0000sO-Qx@approximate.corpus.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/05, Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk> wrote:
> so the return value should not be 4 (or the docs are not right).

This return value simply indicated EINTR (sigwait does not set errno,
read the docs).

The kernel simply doesn't restart the function in case of a signal. 
It should do this, though.
