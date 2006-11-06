Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753894AbWKFWsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753894AbWKFWsX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 17:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753896AbWKFWsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 17:48:23 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:33266 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1753894AbWKFWsW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 17:48:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=bb8BtKE6AQvtWg0EFPoStS0XEGuGcheLOP7aE+XEH91cylwBAhnJZjq4Ik4Q0dXGwzseiL0V65BD9oEys9+k5YtrXHOQY/jzYGk6ICsgqDsWkJVg+IwK6izprsXmzyrUeYaUDyYxKA8zWi7vB2UHM1RVSERyYiv/eTVMN72emoM=
Message-ID: <d120d5000611061448p73bcfec5xb91bb4f454312eb9@mail.gmail.com>
Date: Mon, 6 Nov 2006 17:48:20 -0500
From: "Dmitry Torokhov" <dtor@insightbb.com>
To: "=?ISO-8859-1?Q?N=E9meth_M=E1rton?=" <nm127@freemail.hu>
Subject: Re: [PATCH] input: map BTN_FORWARD to button 2 in mousedev
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
In-Reply-To: <454DCDBC.7060201@freemail.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <454DCDBC.7060201@freemail.hu>
X-Google-Sender-Auth: 975cd81d89f82853
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/06, Németh Márton <nm127@freemail.hu> wrote:
> From: Márton Németh <nm127@freemail.hu>
>
> In mousedev the BTN_LEFT and BTN_FORWARD were mapped to mouse button 0, causing
> that the user space program cannot distinguish between them through /dev/input/mice.
> The BTN_FORWARD is currently used in the synaptics.c, logips2pp.c and in alps.c. All
> mice have BTN_LEFT, but not all have BTN_MIDDLE (e.g. Clevo D410J laptop). Mapping
> BTN_FORWARD to mouse button 2 makes the BTN_FORWARD button useful on the mentioned
> laptop.
>

I'd rather not touch mappings in legacy mousedev driver. I believe
both synaptics and evdev X drivers will correctly recognize
BTN_FORWARD, is there any reason you are not using them?

-- 
Dmitry
