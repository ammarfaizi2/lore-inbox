Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266603AbUIPCgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266603AbUIPCgi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 22:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266790AbUIPCge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 22:36:34 -0400
Received: from holomorphy.com ([207.189.100.168]:56736 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266603AbUIPCgU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 22:36:20 -0400
Date: Wed, 15 Sep 2004 19:36:04 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Albert Cahalan <albert@users.sf.net>
Cc: Jakub Jelinek <jakub@redhat.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>, ak@muc.de
Subject: Re: get_current is __pure__, maybe __const__ even
Message-ID: <20040916023604.GH9106@holomorphy.com>
References: <1095288600.1174.5968.camel@cube> <20040915231518.GB31909@devserv.devel.redhat.com> <20040915232956.GE9106@holomorphy.com> <1095300619.2191.6392.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095300619.2191.6392.camel@cube>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 07:15:18PM -0400, Jakub Jelinek wrote:
>>> current will certainly change in schedule (),

On Wed, Sep 15, 2004 at 10:10:20PM -0400, Albert Cahalan wrote:
> Not really!

Yes it does. The interior of schedule() is C and must be compiled also.


At some point in the past, I wrote:
>> Why would barrier() not suffice?

On Wed, Sep 15, 2004 at 10:10:20PM -0400, Albert Cahalan wrote:
> I don't think even barrier() is needed.
> Suppose gcc were to cache the value of
> current over a schedule. Who cares? It'll
> be the same after schedule() as it was
> before.

Not over a call to schedule(). In the midst of schedule().


-- wli
