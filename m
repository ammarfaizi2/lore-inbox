Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267366AbTA1QsA>; Tue, 28 Jan 2003 11:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267375AbTA1QsA>; Tue, 28 Jan 2003 11:48:00 -0500
Received: from adsl-67-121-154-100.dsl.pltn13.pacbell.net ([67.121.154.100]:4320
	"EHLO kanoe.ludicrus.net") by vger.kernel.org with ESMTP
	id <S267366AbTA1Qr6>; Tue, 28 Jan 2003 11:47:58 -0500
Date: Tue, 28 Jan 2003 08:57:13 -0800
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com
Subject: [-mm6] lost ticks in ACPI
Message-ID: <20030128165713.GA24431@ludicrus.ath.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
From: Joshua Kwan <joshk@ludicrus.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I get the following while booting -mm6 on my laptop:

Warning! Detected 5521 micro-second gap between interrupts.
  Compensating for 4 lost ticks.
Call Trace:
 [<c010a79f>] handle_IRQ_event+0x38/0x5c
 [<c010a9b4>] do_IRQ+0x9a/0x120
 [<c01c4a17>] acpi_ex_system_io_space_handler+0x0/0x6f
 [<c0109538>] common_interrupt+0x18/0x20
 [<c01c4a17>] acpi_ex_system_io_space_handler+0x0/0x6f
 [<c01b89e6>] acpi_os_write_port+0x3d/0x57
 [<c01c4a65>] acpi_ex_system_io_space_handler+0x4e/0x6f
 [<c01bd620>] acpi_ev_address_space_dispatch+0xe9/0x160
 [<c01c168f>] acpi_ex_access_region+0x7e/0x80
 [<c01c18a7>] acpi_ex_field_datum_io+0x1c5/0x1e3
 [<c01c1976>] acpi_ex_write_with_update_rule+0xb1/0x14d
 [<c01c18a7>] acpi_ex_field_datum_io+0x1c5/0x1e3
 [<c01c1ee0>] acpi_ex_insert_into_field+0x155/0x349
 [<c01c8a13>] acpi_ns_local+0x13/0x57
 [<c01c015c>] acpi_ex_write_data_to_field+0x11d/0x2c4
 [<c01c72ab>] acpi_ns_lookup+0x150/0x381
 [<c01c4dce>] acpi_ex_store_object_to_node+0x6d/0xc7
 [<c01c22db>] acpi_ex_opcode_1A_1T_1R+0xde/0x5f9
 [<c01c301d>] acpi_ex_resolve_operands+0xff/0x332
 [<c01baf1a>] acpi_ds_exec_end_op+0x2b6/0x2bc
 [<c01cacb5>] acpi_ps_parse_loop+0x531/0x998
 [<c01d165c>] acpi_ut_create_generic_state+0xf/0x1a
 [<c01bafaf>] acpi_ds_scope_stack_push+0x59/0xc6
 [<c01d1503>] acpi_ut_acquire_mutex+0x74/0x94
 [<c01d158f>] acpi_ut_release_mutex+0x6c/0x86
 [<c01d03d2>] acpi_ut_acquire_from_cache+0x63/0xe1
 [<c01d03d2>] acpi_ut_acquire_from_cache+0x63/0xe1
 [<c01cb300>] acpi_ps_parse_aml+0x1e4/0x1ec
 [<c01bce25>] acpi_ds_init_aml_walk+0xc5/0x12a
 [<c01cbceb>] acpi_psx_execute+0x1ff/0x254
 [<c01c867e>] acpi_ns_execute_control_method+0x58/0x76
 [<c01c860e>] acpi_ns_evaluate_by_handle+0xa9/0xc1
 [<c01c8481>] acpi_ns_evaluate_relative+0xed/0x104
 [<c01d158f>] acpi_ut_release_mutex+0x6c/0x86
 [<c01c845e>] acpi_ns_evaluate_relative+0xca/0x104
 [<c01d08ab>] acpi_ut_evaluate_object+0x3b/0x161
 [<c01d0c19>] acpi_ut_execute_STA+0x2f/0x5e
 [<c01c960b>] acpi_ns_init_one_device+0x6d/0xee
 [<c01c9afa>] acpi_ns_walk_namespace+0xda/0x13c
 [<c01c9495>] acpi_ns_initialize_devices+0x54/0x58
 [<c01c959e>] acpi_ns_init_one_device+0x0/0xee
 [<c01d1a71>] acpi_initialize_objects+0x2e/0x34
 [<c01b2d5d>] subsystem_register+0x1b/0x2f
 [<c0105069>] init+0x38/0x155
 [<c0105031>] init+0x0/0x155
 [<c010720d>] kernel_thread_helper+0x5/0xb

this happens several times during the boot, mostly in the same order of events.

HTH
Regards
Josh

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+NrZp6TRUxq22Mx4RAg+4AJ9xZErWxmUgHV0JLhwdporNZFDSFwCfeS8e
LuputqHf4VvgTWb0IhYLoiQ=
=SK+R
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
