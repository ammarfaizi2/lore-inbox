Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290200AbSBFHbm>; Wed, 6 Feb 2002 02:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290192AbSBFHbT>; Wed, 6 Feb 2002 02:31:19 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:32715 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S290185AbSBFHbQ>; Wed, 6 Feb 2002 02:31:16 -0500
Date: Wed, 6 Feb 2002 09:24:21 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
        Patrick Mochel <mochel@osdl.org>
Subject: Re: driverfs support for motherboard devices
In-Reply-To: <20020205173912.GA165@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0202060921380.8308-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Feb 2002, Pavel Machek wrote:

> +static void __init init_8259A_devicefs(void)
> +{
> +	device_register(&device_i8259A);
> +	strcpy(device_i8259A.name, "i8259A");
> +	strcpy(device_i8259A.bus_id, "0020");
> +	device_i8259A.parent = &sys_iobus;

I'm not entirely familiar with the driverfs API but wouldn't an API 
function to do all that strcpy and other init assignments be a bit 
cleaner? I see lots of retyping going on otherwise, someone feel free to 
hit me with a clue bat if i'm missing something...

Cheers,
	Zwane Mwaikambo


