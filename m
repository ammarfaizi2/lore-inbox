Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293013AbSBVVvh>; Fri, 22 Feb 2002 16:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293014AbSBVVv1>; Fri, 22 Feb 2002 16:51:27 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:58896 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S293013AbSBVVvK>;
	Fri, 22 Feb 2002 16:51:10 -0500
Date: Fri, 22 Feb 2002 13:45:32 -0800
From: Greg KH <greg@kroah.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: G?rard Roudier <groudier@free.fr>, Arjan van de Ven <arjanv@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
Message-ID: <20020222214532.GB10333@kroah.com>
In-Reply-To: <20020222154011.B5783@suse.cz> <20020221211606.F1418-100000@gerard> <20020222223444.A7238@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020222223444.A7238@suse.cz>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Fri, 25 Jan 2002 19:36:42 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2002 at 10:34:44PM +0100, Vojtech Pavlik wrote:
> 
> And because of that, I do not think that having the host adapters decide
> what device gets what number is a good idea. They should provide the
> information if they have it, but the final decision should definitely be
> done in userspace, by the hotplug agent.
> 
> Ie. it should be configurable.

I totally agree.  Network devices are now configured by the hotplug
agent and can handle different PCI probe order, rearranging cards in a
system, and other fun things that cause them to be initialized in a
different order.  All of this now "just works" as far as the user is
concerned.

I don't see why SCSI should be any different.

thanks,

greg k-h
