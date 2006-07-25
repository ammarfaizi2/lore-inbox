Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751526AbWGYUcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbWGYUcq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 16:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751532AbWGYUcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 16:32:46 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:23435 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751509AbWGYUcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 16:32:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Qi0COzhR/5+AKcO0eXhGMhcye4HAZDM/+cKNSJp3zITvT1+62UKjUZzSxYbNScpKzyQiOmM8krzHR6Q+i2ChWzu7I8mNlKAV9ZWO81HUuWdPpsp0rm4Zy6mUlppV8pD44Y40rwgkOcbOEauTbrgrDGHGIkNII/dBzunVPiMKZK4=
Message-ID: <d120d5000607251332ma001b27teaf0f07d6c122362@mail.gmail.com>
Date: Tue, 25 Jul 2006 16:32:44 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Komal Shah" <komal_shah802003@yahoo.com>
Subject: Re: [PATCH] OMAP: Add keypad driver #2
Cc: akpm@osdl.org, juha.yrjola@solidboot.com, tony@atomide.com,
       ext-timo.teras@nokia.com, r-woddruff2@ti.com,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
In-Reply-To: <1153825050.6486.266809347@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1153825050.6486.266809347@webmail.messagingengine.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/06, Komal Shah <komal_shah802003@yahoo.com> wrote:
> Andrew/Tony/Richard,
>
> This is a revised patch as per the review comments from the Andrew
> on thread:
>
> http://lkml.org/lkml/2006/7/22/19
>
> Please review it and give me the Ack if looks ok.
>

Hi Komal,

The driver needs to handle failures in input_register_device() and
unwind initialization properly. Also you do not need to do double
negation of the value when calling input_report_key() because it will
do it for you.

Also you might consider setting up keycodetable, keycodesize, etc in
the input device - this way you can change keymap at runtime via
ioctls.

-- 
Dmitry
