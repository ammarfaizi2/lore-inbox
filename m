Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbUKCIFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbUKCIFm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 03:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbUKCIFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 03:05:41 -0500
Received: from mx.go2.pl ([193.17.41.41]:34743 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S261460AbUKCIF1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 03:05:27 -0500
Message-ID: <418892C8.8000806@o2.pl>
Date: Wed, 03 Nov 2004 09:11:52 +0100
From: GNicz <gnicz@o2.pl>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: question on common error-handling idiom
References: <4187E920.1070302@nortelnetworks.com>
In-Reply-To: <4187E920.1070302@nortelnetworks.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some code parts is using diffirent error handling.

if(err1) {
	clenup1;
	return -ERR1;
}

...

if(err2) {
	cleanup2;
	return -ERR2;
}

Shouldn't it be converted into:

err = -ERR1;
if(err1)
	goto cleanup1;

...

err = -ERR2;
if(err2)
	goto cleanup2;

I think there should be one methond, which will be used in all kernel code.

Regards, GNicz
