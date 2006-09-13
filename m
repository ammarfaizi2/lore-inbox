Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbWIMUVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWIMUVT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 16:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbWIMUVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 16:21:19 -0400
Received: from minus.inr.ac.ru ([194.67.69.97]:36755 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id S1750864AbWIMUVS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 16:21:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ms2.inr.ac.ru;
  b=DhiDyB+9E9LNPkyUaenTHQKWm/b30RVpkr4d4mCiVtXKiUxd4qbHG5sgd/63FGzqJQOhEEf1g94jZNBWkJneT1Mc12ppKVA4trnCuekArqKW42sZcvcsqztUXpz75FEUIKeDY8qEK0uOUWKHKBx13k3m+NTueDqDCDdrWX6UkNU=;
Date: Thu, 14 Sep 2006 00:20:29 +0400
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
To: David Stevens <dlstevens@us.ibm.com>
Cc: Jeff Layton <jlayton@poochiereds.net>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, netdev-owner@vger.kernel.org
Subject: Re: [PATCH] make ipv4 multicast packets only get delivered to sockets	that are joined to group
Message-ID: <20060913202029.GA4666@ms2.inr.ac.ru>
References: <1158156835.15449.40.camel@dantu.rdu.redhat.com> <OF0C86B64A.DE64FE98-ON882571E8.004F57A7-882571E8.004FDDED@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF0C86B64A.DE64FE98-ON882571E8.004F57A7-882571E8.004FDDED@us.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> IPv6 behaves the same way.

Actually, Linux IPv6 filters received multicasts, inet6_mc_check() does
this.

IPv4 does not. I remember that attempts to do this were made in the past
and failed, because some applications, related to multicast routing,
did expect to receive all the multicasts even though they did not join
any multicast addresses. So, it was left intact.

Alexey
