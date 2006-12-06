Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935072AbWLFPYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935072AbWLFPYN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 10:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934378AbWLFPYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 10:24:13 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:35389 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935072AbWLFPYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 10:24:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I4kg50d7ccGMpxgPbuRCyN7gNP8msz1T1JPYNjJRkEpEOPehTzVXf+wM6npZibqgKE23kQNbbcry/z9jFIfh6osQTIC/T9QId++RoRAuyTRm4aMAFABtT+W3TRMwDzcmiUHM3y5+V+w6aleTs8XLEXlx2qaTzxZjO5aMMMQluDc=
Message-ID: <d120d5000612060724m7ebe0b1w5c0f24ba52ca75e7@mail.gmail.com>
Date: Wed, 6 Dec 2006 10:24:08 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Dan Williams" <dcbw@redhat.com>
Subject: Re: [RFC] rfkill - Add support for input key to control wireless radio
Cc: "Ivo van Doorn" <ivdoorn@gmail.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, "John Linville" <linville@tuxdriver.com>,
       "Jiri Benc" <jbenc@suse.cz>,
       "Lennart Poettering" <lennart@poettering.net>,
       "Johannes Berg" <johannes@sipsolutions.net>,
       "Larry Finger" <Larry.Finger@lwfinger.net>
In-Reply-To: <1165418339.2750.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200612031936.34343.IvDoorn@gmail.com>
	 <d120d5000612041415r2f471e78s4feb86d22b7706d5@mail.gmail.com>
	 <200612050027.15253.IvDoorn@gmail.com>
	 <d120d5000612060637s69ff235fo85a2db923a728a00@mail.gmail.com>
	 <1165418339.2750.5.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/06, Dan Williams <dcbw@redhat.com> wrote:
> On Wed, 2006-12-06 at 09:37 -0500, Dmitry Torokhov wrote:
> >
> > Fans of the 3rd method, speak up ;)
>
> I think I brought up the 3rd method initially in this thread.  I'm not
> necessarily advocating it, but I wanted to be sure people realized that
> this was a case, so that a clear decision would be made to support it or
> not to support it.
>
> (2) makes the most sense to me.  I don't think we need to care about
> edge-cases like "But I only wanted to rfkill _one_ of my bluetooth
> dongles!!!", that's just insane.
>
> But using (2) also begs the question, can we _always_ identify what
> interface the rfkill belongs to?  In Bastien's laptop, the rfkill switch
> _automatically_ disconnects the internal USB Bluetooth device from the
> USB bus, and uses the normal ipw2200 rfkill mechanism, whatever that is.
> In this case, you simply do not get an event that the bluetooth device
> is disabled from a button somewhere; it's just gone, and you'd have to
> do some magic to disable other bluetooth devices as well.
>

Is this the same physical button? If so then for this particular box
we'd just have to send 2 events - KEY_WIFI and KEY_BLUETOOTH at the
same time.

-- 
Dmitry
