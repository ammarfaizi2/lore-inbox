Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266163AbUI0GMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266163AbUI0GMj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 02:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266173AbUI0GMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 02:12:39 -0400
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:57003 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266155AbUI0GMe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 02:12:34 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Subject: Re: [ACPI] PATCH-ACPI based CPU hotplug[2/6]-ACPI Eject interface support
Date: Mon, 27 Sep 2004 01:12:28 -0500
User-Agent: KMail/1.6.2
Cc: Len Brown <len.brown@intel.com>, acpi-devel@lists.sourceforge.net,
       LHNS list <lhns-devel@lists.sourceforge.net>,
       Linux IA64 <linux-ia64@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040920092520.A14208@unix-os.sc.intel.com> <200409201812.45933.dtor_core@ameritech.net> <20040924162823.B27778@unix-os.sc.intel.com>
In-Reply-To: <20040924162823.B27778@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200409270112.29422.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 September 2004 06:28 pm, Keshavamurthy Anil S wrote:
> +typedef void acpi_device_sysfs_files(struct kobject *,
> +                               const struct attribute *);
> +
> +static void setup_sys_fs_device_files(struct acpi_device *dev,
> +               acpi_device_sysfs_files *func);
> +
> +#define create_sysfs_device_files(dev) \
> +       setup_sys_fs_device_files(dev, (acpi_device_sysfs_files *)&sysfs_create_file)
> +#define remove_sysfs_device_files(dev) \
> +       setup_sys_fs_device_files(dev, (acpi_device_sysfs_files *)&sysfs_remove_file)


Hi Anil,

It looks very nice except for the part above. I am really confused what the
purpose of this code is... It looks like it just complicates things?

-- 
Dmitry
