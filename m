Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLOWm4>; Fri, 15 Dec 2000 17:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129319AbQLOWmq>; Fri, 15 Dec 2000 17:42:46 -0500
Received: from [199.26.153.10] ([199.26.153.10]:62989 "EHLO fourelle.com")
	by vger.kernel.org with ESMTP id <S129183AbQLOWmh>;
	Fri, 15 Dec 2000 17:42:37 -0500
Message-ID: <3A3A96CB.171990B4@fourelle.com>
Date: Fri, 15 Dec 2000 14:10:19 -0800
From: Adam Scislowicz <adams@fourelle.com>
Organization: Fourelle Systems, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11-ac4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Non-Blocking socket (SOCK_STREAM send) - SOLVED
In-Reply-To: <3A3953DB.CDA2DF4E@fourelle.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I Previously Wrote:

> Could someone explain why send is failing with EPIPE on the 2.4.x
> kernel, while it is working with the 2.2.x kernels.

It turns our the socket family was not being set to AF_INET :/
It was working in 2.2.x because in our situation the sock family was being
initialized to AF_INET, this is not
behavious we should have been depending on. Sorry 'bout that.

 -Adam

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
