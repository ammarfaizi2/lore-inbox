Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264334AbTFEAHu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 20:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264336AbTFEAHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 20:07:50 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:22672 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264334AbTFEAHt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 20:07:49 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 4 Jun 2003 17:19:05 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Ed Vance <EdV@macrolink.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] [2.5] Non-blocking write can block
In-Reply-To: <11E89240C407D311958800A0C9ACF7D1A33EBD@EXCHANGE>
Message-ID: <Pine.LNX.4.55.0306041717230.3655@bigblue.dev.mcafeelabs.com>
References: <11E89240C407D311958800A0C9ACF7D1A33EBD@EXCHANGE>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jun 2003, Ed Vance wrote:

> Do you mean something like the separate O_NDELAY flag under Solar*s? IIRC
> they also use return code EWOULDBLOCK to differentiate the "could not get
> resource" cases from the "no room for more data" cases when O_NONBLOCK is
> used.

Besides the stupid name O_REALLYNONBLOCK, it really should be different
from both O_NONBLOCK and O_NDELAY. Currently in Linux they both map to the
same value, so you really need a new value to not break binary compatibility.



- Davide

