Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWCERAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWCERAi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 12:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWCERAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 12:00:38 -0500
Received: from nproxy.gmail.com ([64.233.182.204]:10537 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932104AbWCERAh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 12:00:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Ha0JbuLTArZdKEg5c3jX4FE15A0ZJnblIGMDWkt6Uqqq5FipA0DJO+T+loRiP+exvu2OiUq7K+QFGsMloRqg38J2ewWqTs4MiyPQO5+P6oeSD0XnUMEH/oGzB6si4SZvIq/nto6kQXmm2FIt2pjtIRdQka3m5/hWHj8Vi4++1RY=
Message-ID: <aec8d6fc0603050900w7aa1f93due29e9c1cf87e9316@mail.gmail.com>
Date: Sun, 5 Mar 2006 18:00:34 +0100
From: "Mateusz Berezecki" <mateuszb@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: memory range R/W triggered breakpoints in kernel ?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello List,

I was thinking about writing some memory R/W access monitor. The only
concern I'm
having is whether it is doable, or are there any already existing and
working solutions like
that for Linux?

The initial concept was to set up some special page fault handler and
mark monitored
memory pages as non present. The monitor pagefault handler would check
if the page
is within monitored location and if yes it would switch to
singlestepping mode and
step the instruction which invoked the pagefault and log the value
which was read/written from
certain address. Afterwards the whole page would be marked as non present again.

Is it possible to succeed with such an approach? Would it work for
memory range mapped to some devices?



kind regards,
Mateusz Berezecki
