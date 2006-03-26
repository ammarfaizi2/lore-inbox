Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWCZWm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWCZWm3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 17:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWCZWm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 17:42:29 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:12518 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932154AbWCZWm2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 17:42:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=paLKKQYHVzfPBmSAeE8w3KBDTUXT47mODmmS6O3tFD19iXAmlsVjvAQ/ffzpnzH77vx5g+4olmpHYILzTJbDVWDoKfg6RVQw/IuAbvz8QO97fSXI141lwF9JiWsjfZxzKVMoV467xGZ1J3pH/CLqd+CHHubacttuxHVEId9GjS8=
Message-ID: <2c0942db0603261442we907cb9x9d81c4a0235531b4@mail.gmail.com>
Date: Sun, 26 Mar 2006 14:42:27 -0800
From: "Ray Lee" <madrabbit@gmail.com>
Reply-To: ray-gmail@madrabbit.org
To: "Edward Chernenko" <edwardspec@yahoo.com>
Subject: Re: [PATCH 2.6.15] Adding kernel-level identd dispatcher
Cc: "Jan Engelhardt" <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20060326194904.24112.qmail@web37702.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060326194904.24112.qmail@web37702.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Comparing with khttpd, we have no need to make
> transfers between userspace and kernelspace;

For any of this to be motivating to anyone here, you'll have to
present an argument as to why this can't be done in userspace. identd
isn't a terribly complex thing -- one would think that a carefully
crafted userspace daemon could saturate any reasonable network
connection.

Conversely, if it can't be done fast from userspace, then people to
hear about that. That means that there's some task the kernel needs to
be made more faster at doing.

And if whatever potential performance problems with the kernel are
fixed, then all applications, including your userspace identd too,
will benefit from the fixes.
