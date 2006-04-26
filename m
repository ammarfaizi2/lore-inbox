Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbWDZOBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbWDZOBX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 10:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964778AbWDZOBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 10:01:22 -0400
Received: from wproxy.gmail.com ([64.233.184.228]:12535 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964776AbWDZOBV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 10:01:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RdvZrYKyRT6niiKFFXzn/DQK3OoL7h2bm4NCDlLN5Va/Dk6Ql3jcH+7YlNLZl6XTdpw3pDB7dFYgRG62d+PM4H35Snh5ilciANHUpAw9CTw84EJH/Mco3SrXAsAUTdg5tReepMsUlRJImvzn+nuPYyy5Ypb9CmjesM9s0m4B770=
Message-ID: <bbe04eb10604260701h77d6f51fy1f95ea7e92e7c2b7@mail.gmail.com>
Date: Wed, 26 Apr 2006 10:01:21 -0400
From: "Kimball Murray" <kimball.murray@gmail.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Cc: "Brown, Len" <len.brown@intel.com>, linux-kernel@vger.kernel.org,
       akpm@digeo.com, kmurray@redhat.com, natalie.protasevich@unisys.com,
       linux-acpi@vger.kernel.org
In-Reply-To: <bbe04eb10604260656h76064baev4f654a929290d35b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <CFF307C98FEABE47A452B27C06B85BB6466487@hdsmsx411.amr.corp.intel.com>
	 <200604261517.06505.ak@suse.de>
	 <bbe04eb10604260656h76064baev4f654a929290d35b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, previous message got sent before I had typed anything!

Andi, I just wanted to be clear that my patch is not a VIA workaround,
it is a VIA workaround workaround.  So please don't remove my patch
while leaving in the original VIA workaround.  That will break our
platform, and possibly others.

I don't know if there's an easy way to have both the VIA workaround
(Natalie's original patch) and the VIA workaround workaround (my
patch) in a more unified construct.

I believe our platform would work fine with the removal of my patch
_and_ the VIA patch.  But, as you say, what about VIA?

-kimball

On 4/26/06, Kimball Murray <kimball.murray@gmail.com> wrote:
> Hi Andi,
>
>
>
> On 4/26/06, Andi Kleen <ak@suse.de> wrote:
> > On Tuesday 25 April 2006 21:53, Brown, Len wrote:
> > > I'd rather see the original irq-renaming patch
> > > and its subsequent multiple via workaround patches
> > > reverted than to further complicate what is becoming
> > > a fragile mess.
> >
> > Sorry rechecking - i already got the patch now. You want me to drop it again?
> >
> > I guess we could drop it all, but VIA must still work afterwards.
> > How would we do that?
> >
> > -Andi
> >
>
