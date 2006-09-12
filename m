Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751311AbWILGJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbWILGJe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 02:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWILGJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 02:09:34 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:22725 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751311AbWILGJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 02:09:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r9e1SvY3yLhlP350Wr9esyXb65F0y1RN4bGt8SD1lUptErXaO18kiER1uqrDGYQhZw4z6xDiQb5frcDsuEMFsOJ178tCKmvxcn9bnGywU+ViJZU7i+9y+6pCjHLEmH3JTw43Ylt0lyjenjMeJ3RJ3LiSPghIUVm+wNUS3cBWpI4=
Message-ID: <653402b90609112309p7be570a2ra9e1c22ad9c7a0d7@mail.gmail.com>
Date: Tue, 12 Sep 2006 08:09:22 +0200
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "Greg KH" <greg@kroah.com>
Subject: Re: [PATCH 2.6.17.13] display: Driver ks0108 and cfag12864b
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060912035131.GA27472@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <653402b90609111627q661cded8l757129311fbe92d4@mail.gmail.com>
	 <20060912035131.GA27472@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/06, Greg KH <greg@kroah.com> wrote:
>
> The patch is linewrapped :(
>

Please tell me if the next one is linewrapped too.

>
> Why would you need to touch udev?  It will handle stuff loaded at any
> point in time automatically.  You don't have to "update udev" at all.
>

My fault. My firsts tests were on a Vector Linux, and, I don't know
why (bad cfg I guess), but udev didn't create the nodes automatically.
Now, in Debian, it does. I have noticed that and the last patch
doesn't have such lines. Sorry.

>
> Do you really mean for your header file to be under the GPL for
> userspace programs?
>

Ups, it is just an example for a user-space program that wants to use
the cfag12864b. I will remove the License line anyway.


>
> Which version of the GPL?
>

The same as the kernel, I think. Is that right?

> [about useless printk's]
> Is this really needed?
>

It isn't anymore. In the patch it is also removed and all the printks
improved, as Alexey Dobriyan told me also to do.

> "Display" is very generic, people will think it is for video stuff too.
> LCD perhaps might be better?
>

I thought the same, but LCD is already used by the "PDA Frontal LCD
Panel". They got the "linux/lcd.h" and "drivers/lcd/*", as well as a
fixed major number.

So I thought "bigger" and, IMHO a new folder for this kind of
misc-secondary-display devices (LCD or not) will be fine.

I think (maybe I'm wrong but...), we can just put the drivers right
there. There are a lot of this kind of hardware, but it will take time
to code more drivers. So if the resulting drivers are so different or
the drivers/* get a major update, relocate them. If not, leave them
until we have enough samples to start classifying.
