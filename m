Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbVH2X2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbVH2X2U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 19:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbVH2X2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 19:28:20 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:22408 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751422AbVH2X2T convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 19:28:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Lvt+o1Hiz4OYQBDRWqivV5wQwjmwv+YF20JxxW0hTFT/JZY5HoWOIpDLb61OnwWqW6/I4RDFcBvK77jUdFh+5YaIksE+1TN8Rrs3kQ2MTSVKcyWN6nejrACnCB662JXtEG8MutfpHS5wcm/KZs0vZpuszHiwmapZl4gPGPkJ+mA=
Date: Tue, 30 Aug 2005 01:28:13 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Stephane Wirtel <stephane.wirtel@belgacom.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.6.13 : __check_region is deprecated
Message-Id: <20050830012813.7737f6f6.diegocg@gmail.com>
In-Reply-To: <20050829231417.GB2736@localhost.localdomain>
References: <20050829231417.GB2736@localhost.localdomain>
X-Mailer: Sylpheed version 2.1.1+svn (GTK+ 2.8.2; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 30 Aug 2005 01:14:17 +0200,
Stephane Wirtel <stephane.wirtel@belgacom.net> escribió:

> Is there a function to replace this deprecated function ?

request_region

> Why is it deprecated ?

>From http://lists.osdl.org/pipermail/kernel-janitors/2004-January/000346.html:
"The reason that check_region() is deprecated is that it is racy.
It could report that a region is available and then another driver
could immediately reserve that region, since check_region() doesn't
have any reservation capability."


/me wonders why check_region has not been killed, it has been
deprecated for years; killing it would force developers to fix it
and would help to identify unmaintained drivers...
