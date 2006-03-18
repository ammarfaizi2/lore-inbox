Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751071AbWCRWCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbWCRWCp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 17:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbWCRWCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 17:02:45 -0500
Received: from uproxy.gmail.com ([66.249.92.196]:18621 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751070AbWCRWCo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 17:02:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dEVcIjLzxd8wqlb47WGQFgk1SAEXC1xo5ZyWgzW0TZy6BYoDTnnaQ+FHA0HnOo4G34/qVLqogJ609wqnwxpc6QGOOF+79A97ds+oIBYDFmEwfcNo7633EPLXuR6ALv815JQJPcHL362JFlcur8rWakSRo+m+OilRMpy9lrSPdrA=
Message-ID: <2c0942db0603181402o4115999jb990ac05cca7fb9e@mail.gmail.com>
Date: Sat, 18 Mar 2006 14:02:43 -0800
From: "Ray Lee" <madrabbit@gmail.com>
Reply-To: ray-gmail@madrabbit.org
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Subject: Re: [patch 1/2] Validate itimer timeval from userspace
Cc: "Andrew Morton" <akpm@osdl.org>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org, mingo@elte.hu, trini@kernel.crashing.org
In-Reply-To: <9a8748490603181245v47b9f0a5v1ef252f91c30a7d2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060318142827.419018000@localhost.localdomain>
	 <20060318142830.607556000@localhost.localdomain>
	 <20060318120728.63cbad54.akpm@osdl.org>
	 <1142712975.17279.131.camel@localhost.localdomain>
	 <20060318123102.7d8c048a.akpm@osdl.org>
	 <9a8748490603181245v47b9f0a5v1ef252f91c30a7d2@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> If the change only affects buggy apps (as Thomas says), then it seems
> completely obvious to me that the change should be made.

But the app isn't buggy, it's just not coded to some arbitrary spec.
Further, an arbitrary spec that *the kernel didn't implement*. The app
author could very well have been competent and tested that behavior in
a ten line program (I do that sort of code *all the time* to test
corner cases that aren't clear in man pages). Once tested, they found
out -1 is an effectively infinite timeout, went "Hey, cool, that makes
sense", and went on with their day.

You're now arguing that we should break apps -- possibly well tested
apps -- because they didn't implement a spec that the kernel itself
wasn't implementing.

That's just nuts.

> 3. Correct applications are unaffected.

You're assuming that the apps that we'd break are incorrect. That's a
big assumption. Try imagining instead that it's a well-tested app that
passed QA with flying colors on a previous version of the kernel. They
exist. Honest.

Ray
