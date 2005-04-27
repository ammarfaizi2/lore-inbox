Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbVD0Pms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbVD0Pms (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 11:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbVD0Pms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 11:42:48 -0400
Received: from [195.23.16.24] ([195.23.16.24]:57270 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261627AbVD0Pml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 11:42:41 -0400
Message-ID: <426FB2C5.9030906@grupopie.com>
Date: Wed, 27 Apr 2005 16:41:57 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: k8 s <uint32@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Doubt Regarding Multithreading and Device Driver
References: <699a19ea050427080545fb1676@mail.gmail.com>	 <20050427151040.GA5717@roonstrasse.net> <699a19ea05042708305fb7194b@mail.gmail.com>
In-Reply-To: <699a19ea05042708305fb7194b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

k8 s wrote:
> But i am sharing something in file->private_data which is a private
> variable to the process(that is passed to the device driver
> functions). Isn't it?

How do you make sure that there is only one process accessing the file?

If you open a file and then fork another process, both have access to 
the file using the same file descriptor.

You might want to do precisely this for a number of reasons, like having 
one process that send commands to a device while the other receives 
status information...

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
