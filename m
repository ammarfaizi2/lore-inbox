Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWHNPP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWHNPP0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 11:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbWHNPPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 11:15:25 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:61284 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932106AbWHNPPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 11:15:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AaStnbIn8X0PUsNV/QqaYLrs0EiuoUtEm6E5lE31AI6nqYxsLcw2OeHyZMQMdwWnRIQkNORNQhAn/txdG5br/VS4BrF5buUEpNo8dJZn7QQHW8Qqh4Xe+J3T80iUUtEoZ6LJE5tpimuhEphoMbZTFytW8OULcAHpgLyAUUqGeyQ=
Message-ID: <d120d5000608140815g121a84a3o58919582d5797305@mail.gmail.com>
Date: Mon, 14 Aug 2006 11:15:23 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Dmitry Torokhov" <dtor@insightbb.com>,
       "Magnus Vigerl???f" <wigge@bigfoot.com>,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       "Vojtech Pavlik" <vojtech@suse.cz>
Subject: Re: input: evdev.c EVIOCGRAB semantics question
In-Reply-To: <20060814145848.GA4095@inferi.kami.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608121724.16119.wigge@bigfoot.com>
	 <20060812165228.GA5255@aehallh.com>
	 <200608122000.47904.dtor@insightbb.com>
	 <20060813032821.GB5251@aehallh.com>
	 <d120d5000608140720o4e8cc039u278fea6ccc0aae07@mail.gmail.com>
	 <20060814145848.GA4095@inferi.kami.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mattia,

On 8/14/06, Mattia Dongili <malattia@linux.it> wrote:
>
> pbbuttonsd is a nice utility that (between the other things) monitors
> keyboard and mouse activity and eventually sends the laptop to sleep.
> The synaptics driver uses EVIOCGRAB and they don't work nice together
> (eg: laptop goes to sleep even if actively using your touchpad)...
>
> Now, with your proposal a user not using the synaptics driver and would
> lose multiplexing to /dev/input/mice.
>

Yes, you are right, it won't work.

> So why not just make EVIOCGRAB mean "don't send events to
> mousedev but still report data to others opening the device"?
>

That darn layering thing. We don't want evdev to know about all other
handlers there are.

-- 
Dmitry
