Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262783AbTENURZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 16:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbTENURZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 16:17:25 -0400
Received: from port-212-202-185-200.reverse.qdsl-home.de ([212.202.185.200]:53126
	"EHLO gw.localnet") by vger.kernel.org with ESMTP id S262783AbTENURC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 16:17:02 -0400
Message-ID: <3EC2A732.2080003@trash.net>
Date: Wed, 14 May 2003 22:29:38 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030430 Debian/1.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: set state to XFRM_STATE_DEAD before calling xfrm_state_put
 in pfkey_msg2xfrm_state
References: <3EC259FD.1010706@trash.net> <20030514.131319.70202360.davem@redhat.com>
In-Reply-To: <20030514.131319.70202360.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David S. Miller wrote:

>You didn't test this change.  x->type is a pointer, not a place where
>you put XFRM_STATE_DEAD, a simple compile test would have alerted
>this to you.
>  
>

Sorry about that, i recreated the fix in a different tree and broke it.

>This also means you couldn't possibly have tested if this even
>makes the assertion go away, it couldn't possibly have fixed this..
>
>The correct fix, of course, is to set x->km.state to this value.
>This is what I've done in my tree.
>
>Please be a LOT more careful with your changes.
>

Promised.


