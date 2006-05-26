Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbWEZRRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWEZRRA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 13:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWEZRRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 13:17:00 -0400
Received: from nz-out-0102.google.com ([64.233.162.207]:22264 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751176AbWEZRRA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 13:17:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ENB4inI0Za8AY9hREqREG0K2vokG53njuK9VeWgFCwAIRw+WF5bLrDYFhG8MBtUVkDtTAK26sI09U1maPGzsUt7KDBjJROP5Sh+nJrsZoYO6hiyHAqdHjp4OMxf/I8wIR62NLHE6n7/Yc+Wga+yyzPRLgSyalGCb/llZ/WG87iM=
Message-ID: <9e4733910605261016x7de14813ib2b83ba5a55a08c4@mail.gmail.com>
Date: Fri, 26 May 2006 13:16:27 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Revised, kernel design: support for multiple local users
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please comment on this version, it removes any reference to other applications.

A central, unanswered question in the graphics debate is whether the
kernel should directly support multiple users logged into video cards.
Currently this is not supported. A simple example of this is a two
headed video card and two keyboards. Should the kernel support two
independent users logged into these heads and give them the ability to
control their environment without needing to be root?

This situation commonly occurs in Internet cafes, kiosks, schools,
etc. There are several out of tree patches addressing this. I also
believe there are multiple vendors selling products in this
configuration.

An alternative model with kernel support would work something like
this. Devices are created for each video head. Devices (video, mouse,
keyboard, usb ports, cdrom, etc) are marked as belonging in a console
grouping. When you log in ownership of the grouped devices is assigned
to you.

Now that you have ownership of the devices you are able to control
them without being root. If you want to change your video mode ask
your video device to do it (this is not a comment on how the video
device achieves the mode change). Since the devices are locally owned
each user can independently run whatever app they choose.

I am obviously leaving out some details about how sharing the
resources of a single video card between heads is achieved. If you
prefer, think of this scenario for two installed graphics cards. This
is not an attempt to detail how to build the feature.

The question is, do we want local multiuser support in the kernel, or
should it be an application feature?


-- 
Jon Smirl
jonsmirl@gmail.com
